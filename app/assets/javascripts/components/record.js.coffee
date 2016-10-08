@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: ReactDOM.findDOMNode(@refs.title).value
      date: ReactDOM.findDOMNode(@refs.date).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
      approved: false
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data

  handleApprove: (e) ->
    e.preventDefault()
    data =
      approved: true
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data

  renderEdit: ->
    if !@props.record.approved
      React.DOM.a
        className: 'btn btn-default'
        onClick: @handleToggle
        'Edit'

  renderApprove: ->
    if @props.approveable and !@props.record.approved
      React.DOM.a
        className: 'btn btn-default'
        onClick: @handleApprove
        'Approve'
    else if @props.record.approved
      React.DOM.a
        className: 'btn btn-success disabled'
        'Approved'

  renderDelete: ->
    if @props.deleteable or (@props.isOwner and !@props.record.approved)
      React.DOM.a
        className: 'btn btn-danger'
        onClick: @handleDelete
        'Delete'

  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, totalFormat(@props.record.amount, @props.record.isHours)
      React.DOM.td null, @props.record.name
      React.DOM.td null,
        @renderEdit()
        @renderApprove()
        @renderDelete()

  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'date'
          defaultValue: @props.record.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'float'
          defaultValue: @props.record.amount
          ref: 'amount'
      React.DOM.td null, @props.record.name
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
