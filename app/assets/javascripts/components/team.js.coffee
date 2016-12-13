@Team = React.createClass

  getInitialState: ->
    edit: false
    supervisor: @props.supervisor
    employees: @props.employees

  getDefaultProps: ->
    employees: []

  addEmployee: (employee) ->
    employees = React.addons.update(@state.employees, { $push: [employee] })
    @setState employees: employees

  deleteEmployee: (employee) ->
    index = @state.employees.indexOf employee
    employees = React.addons.update(@state.employees, { $splice: [[index, 1]] })
    @replaceState employees: employees

  updateEmployee: (employee, data) ->
    index = @state.employees.indexOf employee
    employees = React.addons.update(@state.employees, { $splice: [[index, 1, data]] })
    @replaceState employees: employees

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
      url: "/relationships/#{ @props.supervisor.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.supervisor

  handleEdit: (e) ->
    e.preventDefault()
    data =
      name: ReactDOM.findDOMNode(@refs.name).value
      content: ReactDOM.findDOMNode(@refs.content).value
      user_id: ReactDOM.findDOMNode(@refs.user_id).value
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/relationships/#{ @props.supervisor.id }"
      dataType: 'JSON'
      data:
        supervisor: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.supervisor, data

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
    React.DOM.li null,
      'Supervisor: '
      @props.supervisor.email
      @renderEdit()
      @renderDelete()
      React.DOM.ul null,
        for employee in @state.employees
          React.createElement Employee, key: employee.id, employee: employee, handleDeleteEmployee: @deleteEmployee, handleEditEmployee: @updateEmployee

  recordForm: ->

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
