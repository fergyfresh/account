@Team = React.createClass

  getInitialState: ->
    edit: false
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
      url: "/relationships/#{ @props.project_id}"
      data: { project_id: @props.project.id, supervisor_id: @props.project.user_id, employee_id: @props.supervisor.id }
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteSupervisor @props.supervisor

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
      'Reassign Team Lead'

  renderDelete: ->
    React.DOM.a
      className: 'btn btn-danger'
      onClick: @handleDelete
      'Fire'

  recordRow: ->
    React.DOM.li null,
      'Supervisor: '
      @props.supervisor.email
      @renderDelete()
      React.DOM.ul null,
        for employee in @state.employees
          React.createElement Employee, key: employee.id, employee: employee, handleDeleteEmployee: @deleteEmployee, handleEditEmployee: @updateEmployee, project_id: @props.project.id, supervisor_id: @props.supervisor.id
        React.DOM.li null,
          'New employee: '
          React.createElement HireForm, supervisor_id: @props.supervisor.id, project_id: @props.project.id, users: @props.users, handleNewRecord: @addEmployee


  recordForm: ->

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
