@Records = React.createClass
  getInitialState: ->
    records: @props.records

  getDefaultProps: ->
    records: []

  expenses: ->
    expenses = @state.records.filter (val) -> !val.isHours
    expenses.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  hours: ->
    debits = @state.records.filter (val) -> val.isHours
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Time and Expenses'
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @expenses(), text: 'Expenses'
        React.createElement HourBox, type: 'info', amount: @hours(), text: 'Hours'
      React.createElement RecordForm, handleNewRecord: @addRecord, projects: @props.projects
      React.DOM.div
        React.DOM.hr null
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Date'
              React.DOM.th null, 'Contract Number'
              React.DOM.th null, 'Title'
              React.DOM.th null, 'Amount'
              React.DOM.th null, 'Employee'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord, approveable: @props.current_user.supervisor, approved: record.approved, deleteable: @props.current_user.admin, isOwner: @props.current_user.id = record.user_id, projects: @props.projects
