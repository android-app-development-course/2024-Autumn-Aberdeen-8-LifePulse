
@Styles function fancy_hover() {
  .onTouch(
    (event) => {
      if (event.type === TouchType.Down) {
        console.info('down')
        this.bg_color = this.hover_color
      } else if (event.type === TouchType.Up) {
        console.info('up')
        this.bg_color = this.normal_color
      }
    }
  )
}

@Preview
@Component
struct NormalButton{
  @State pic: Resource = $r('app.media.star')
  @State title: string = "Title"
  @State normal_color: string = '#ffffff'
  @State hover_color: string = '#ffcacaca'
  @State bg_color: string = this.normal_color

  build(){
    Column({space: 10}) {
      Image(this.pic)
        .height(24)
        .width(24)
      Text(this.title)
        .fontSize(12)
        .fontColor('#ff606060')
    }
    .width(50)
    .padding(5)
    .borderRadius(5)
    .fancy_hover()
    .backgroundColor(this.bg_color)
    .animation({ duration: 200, curve: Curve.EaseOut })
  }
}

export {NormalButton}