@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm
    supervisors: @props.supervisors

  getDefaultProps: ->
    supervisors: []

  addSupervisor: (supervisor) ->
    projects = React.addons.update(@state.supervisors, { $push: [supervisor] })
    @setState supervisors: supervisors

  deleteSupervisor: (supervisor) ->
    index = @state.projects.indexOf supervisor
    supervisors = React.addons.update(@state.supervisors, { $splice: [[index, 1]] })
    @replaceState supervisors: supervisors

  updateSupervisor: (supervisor, data) ->
    index = @state.supervisors.indexOf supervisor
    supervisors = React.addons.update(@state.supervisors, { $splice: [[index, 1, data]] })
    @replaceState supervisors: supervisors

  render: ->
    React.DOM.div
      className: 'org-chart'
      React.DOM.h2
        className: 'title'
        'Organization Chart.'
      'Project Manager: '
      @props.pm.email
      React.DOM.ul null,
        for supervisor in @state.supervisors
          React.createElement Team, key: supervisor.id, supervisor: supervisor, handleDeleteSupervisor: @deleteSupervisor, handleEditSupervisor: @updateSupervisor, employees: @props.employees[supervisor], project: @props.project
        React.DOM.li null,
          'New supervisor'
