@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  prepSupervisors: ->
    
  render: ->
    React.DOM.div
      className: 'org-chart'
      React.DOM.h2
        className: 'title'
        'Organization Chart.'
      @props.pm.email
      React.DOM.ul {
        className: 'form-control'
      }
      for supervisor in @props.supervisors
        React.DOM.li {
          value: @props.supervisors[supervisor].id },
          @props.supervisors[supervisor].email
