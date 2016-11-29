@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  render: ->
    React.DOM.h1, "Organization Chart."
    React.DOM.div
      className: 'org-chart'
      @props.pm.email
      React.DOM.ul {
        className: 'form-control'
      }, Object.keys(@props.supervisors).map(((supervisor) ->
        React.DOM.li {
          key: supervisor
          value: @props.supervisors[supervisor].id },
          @props.supervisors[supervisor].email
          React.DOM.ul {
            className: 'form-control'
          }, Object.keys(@props.employees).map(((supervisor, employee) ->
            React.DOM.li {
              key: employee
              value: @props.employees[supervisor][employee].id },
              @props.employees[supervisor][employee].email
          ), this)      
      ), this)
