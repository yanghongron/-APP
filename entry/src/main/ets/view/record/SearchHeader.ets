@Component
export default struct SearchHeader{
  build(){
    Row({space: 6}){
      Search({placeholder: '搜索农田'})
        .textFont({size: 18})
        .layoutWeight(1)
    }
    .width('94%')
  }
}