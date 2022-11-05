@react.component
let make = (~image: string, ~pieceName: string) => {
  <div style={ReactDOM.Style.make(~width="100%", ())}>
    <img style={ReactDOM.Style.make(~maxWidth = "100%", ())} src=image alt=pieceName />
  </div>
}
