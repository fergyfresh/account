@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  render: ->
    React.DOM.div
      className: 'org-chart'
      @props.pm.email
    for supervisor in @props.supervisors
      React.DOM.ul supervisor.email
      for employee in @props.employees[supervisor]
        React.DOM.li employee.email

