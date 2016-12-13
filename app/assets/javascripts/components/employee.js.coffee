@Employee = React.createClass

  getInitialState: ->
    edit: false
    employee: @props.employee

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
      url: "/relationships/#{ @props.employee.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteEmployee @props.employee

  handleEdit: (e) ->
    e.preventDefault()
    data =
      name: ReactDOM.findDOMNode(@refs.name).value
      content: ReactDOM.findDOMNode(@refs.content).value
      user_id: ReactDOM.findDOMNode(@refs.user_id).value
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/relationships/#{ @props.employee.id }"
      dataType: 'JSON'
      data:
        supervisor: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.employee, data

  renderEdit: ->
    React.DOM.a
      className: 'btn btn-default'
      onClick: @handleToggle
      'Transfer to another team'

  renderDelete: ->
    React.DOM.a
      className: 'btn btn-danger'
      onClick: @handleDelete
      'Delete'

  recordRow: ->
    React.DOM.li null,
      'Employee: '
      @props.employee.email
      @renderEdit()
      @renderDelete()

  recordForm: ->

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()