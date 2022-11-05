%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

@react.component
let make = () => {
  <div className="App"> 
    <h1>{"Chess"-> React.string}</h1>
    <Board />
  </div>
}
