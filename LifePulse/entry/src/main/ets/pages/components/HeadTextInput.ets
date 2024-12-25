
@Component
struct HeadTextInput {
  @State holder_text: string = ''
  @State head_pic: Resource = $r('app.media.ze_manager')
  @State inputtype: InputType = InputType.Normal
  

  build() {
    Flex() {
      Shape() {
        Rect()
          .width('100%')
          .height(50)
          .fill('#F3F9FF')
          .radius(100)
      }
      GridRow() {
        GridCol({span:2}) {
          Image(this.head_pic)
            .width(31)
            .offset({y:9})
        }
        GridCol({span:10}) {
          TextInput({placeholder: this.holder_text})
            .placeholderFont({size:14})
            .fontSize(14)
            .placeholderColor('#ff9f9f9f')
            .backgroundColor('#00f3f9ff')
            .height(50)
            .type(this.inputtype)
        }.offset({x:-10})
      }.position({})
    }.width('100%')
  }
}

export {HeadTextInput}