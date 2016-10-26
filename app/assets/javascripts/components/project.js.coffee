@Project = React.createClass


  getInitialState: ->
    edit: false
    user_id: ''
    id2email: {}

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/projects/#{ @props.project.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.project

  handleEdit: (e) ->
    e.preventDefault()
    data =
      name: ReactDOM.findDOMNode(@refs.name).value
      content: ReactDOM.findDOMNode(@refs.content).value
      user_id: ReactDOM.findDOMNode(@refs.user_id).value
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/projects/#{ @props.project.id }"
      dataType: 'JSON'
      data:
        project: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.project, data

  renderEdit: ->
    React.DOM.a
      className: 'btn btn-default'
      onClick: @handleToggle
      'Edit'

  renderDelete: ->
    React.DOM.a
      className: 'btn btn-danger'
      onClick: @handleDelete
      'Delete'

  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.project.id
      React.DOM.td null, @props.project.name
      React.DOM.td null, @props.project.content
      React.DOM.td null, @state.id2email[@props.project.user_id]
      React.DOM.td null,
        @renderEdit()
        @renderDelete()

  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null, @props.project.id
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.project.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.project.content
          ref: 'content'
      React.DOM.td null,
        React.DOM.select {
          className: 'form-control'
          defaultValue: @props.project.user_id
          onChange: @handleChange
          ref: 'user_id'
          name: 'user_id'
        }, Object.keys(@props.users).map(((optlabel) ->
          React.DOM.option {
            key: optlabel
            value: @props.users[optlabel].id },
            @props.users[optlabel].email
          ), this)
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
    @state.id2email[id] = email for { id, email } in @props.users
    if @state.edit
      @recordForm()
    else
      @recordRow()
