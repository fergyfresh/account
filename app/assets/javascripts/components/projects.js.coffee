@Projects = React.createClass
  getInitialState: ->
    projects: @props.data

  getDefaultProps: ->
    projects: []

  addRecord: (project) ->
    projects = React.addons.update(@state.projects, { $push: [project] })
    @setState projects: projects

  deleteRecord: (project) ->
    index = @state.projects.indexOf project
    projects = React.addons.update(@state.projects, { $splice: [[index, 1]] })
    @replaceState projects: projects

  updateRecord: (project, data) ->
    index = @state.projects.indexOf project
    projects = React.addons.update(@state.projects, { $splice: [[index, 1, data]] })
    @replaceState projects: projects

  render: ->
    React.DOM.div
      className: 'projects'
      React.DOM.h2
        className: 'title'
        'Projects'
      React.DOM.div
        className: 'row'
      React.createElement ProjectForm, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Project ID'
            React.DOM.th null, 'Project Name'
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Supervisor'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for project in @state.projects
            React.createElement Project, key: project.id, project: project, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord, deleteable: @props.current_user.admin, users: @props.users
