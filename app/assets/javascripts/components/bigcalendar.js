
let BigCalendar = React.createClass({
  render(){
    return (
      <BigCalendar
        events={@props.data}
        defaultDate={new Date()}
      />
    )
  }
})

export default BigCalendar;
