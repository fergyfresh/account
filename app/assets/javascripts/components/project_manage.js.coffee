@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  render: ->
    React.DOM.div
      className: 'org-chart'
      @props.pm.email
      for supervisor in @props.supervisor
        React.DOM.ul supervisor.email
        for employee in employees[supervisor]:
          React.DOM.li employee.email

