@HireForm = React.createClass

  getInitialState: ->
    project_id: @props.project_id
    supervisor_id: @props.supervisor_id 
    employee_id: 'Select new hire.'

  valid: ->
    @state.project_id && @state.supervisor_id && @state.employee_id != 'Select new hire.'

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/relationships/', { relationship: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.select {
          name: 'employee_id'
          value: @state.employee_id
          onChange: @handleChange
          className: 'form-control'
        }, Object.keys(@props.users).map(((optlabel) ->
          React.DOM.option {
            key: optlabel
            value: @props.users[optlabel].id },
            @props.users[optlabel].email
          ), this)
      React.DOM.button
        type: 'submit'
        className: 'btn btn-success'
        disabled: !@valid()
        'Hire'
