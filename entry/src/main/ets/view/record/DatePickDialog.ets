@CustomDialog
export default struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date()
  build() {
    Column({space: 12}){
      DatePicker({
        start: new Date('2023-1-1'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
        })

      Row({space:12}){
        Button('取消')
          .width(120)
          .backgroundColor(Color.Gray)
          .onClick(()=>{
            this.controller.close()
          })
        Button('确定')
          .width(120)
          .backgroundColor('#68FF1F')
          .onClick(()=>{
            //保存日期到全局
            AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
            this.controller.close()
          })
      }
    }
    .padding(12)
  }
}