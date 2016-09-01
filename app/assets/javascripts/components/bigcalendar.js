
this.BigCalendar = React.createClass({
  render(){
    return (
      <BigCalendar
        events={@props.data}
        defaultDate={new Date()}
      />
    )
  }
})
