import { UI_Config } from '../config'

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

@Component
struct Tag {
  private text: string;

  build() {
    Stack() {
      Text('#' + this.text)
        .fontSize(12)
        .fontColor('#ff535353')
    }.backgroundColor('#ffd2d2d2')
    .padding(5)
    .borderRadius(5)
    .margin(5)
  }
}


@Component
struct NavContainer {
  @BuilderParam children: () => void
  private bgColor: string

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Stack() {
        this.children()
      }.width('100%').flexGrow(1)
    }.height(UI_Config.navBarHeight).width('100%').backgroundColor(this.bgColor)
  }
}

@Component
struct SubPageNav {
  private title: string
  private bgColor: string
  private fontColor: string
  @Link clicked: Boolean

  build() {
    NavContainer({bgColor: this.bgColor}) {
      Column() {
        Button('<')
          .onClick(() => {
            this.clicked = true
          })
          .fontColor(this.fontColor)
          .backgroundColor(this.bgColor)
      }.alignItems(HorizontalAlign.Start).width('100%')

      Text(this.title)
        .fontSize(20)
        .fontWeight(600)
        .fontColor(this.fontColor)
    }
  }
}


@Component
struct PageNavWithMenu {
  private bgColor: string
  private fontColor: string
  private menuItems: string[]
  private menuTitles: string[]
  @Link selected: number
  @Link clicked: Boolean

  @Builder
  TabMenu() {
    Menu() {
      ForEach(this.menuItems, (item, index) => {
        MenuItem({content: item})
          .onChange(() => {
            this.selected = index
          })
          .enabled(index !== this.selected)
      })
    }
  }

  build() {
    NavContainer({bgColor: this.bgColor}) {
      Column() {
        Image($r('app.media.CrossCircle'))
          .width(34)
          .height(34)
          .onClick(() => {
            this.clicked = true
          })
      }.alignItems(HorizontalAlign.Start).width('100%').padding({left: 10})

      // Title
      Text(this.menuTitles[this.selected])
        .fontSize(20)
        .fontWeight(600)
        .fontColor(this.fontColor)
        .bindMenu(this.TabMenu)
    }
  }
}


const unit = 12

@Preview
@Component
struct smallCapsule {
  @State bg_color: string = '#ffd7d7d7'
  @State text: string = ''
  @State head_icon: Resource = null
  @State content_len: number = 0

  aboutToAppear() {
    this.content_len = getInspectorByKey('content')['width']
    console.log('content_len', this.content_len)
  }

  build() {
    Column() {
      Stack() {

        Rect()
          .radius(20)
          .fill(this.bg_color)
          .width(unit * 3)
          .height(unit + 2)
          .opacity(0.6)
          .clip(true)


        Row() {
          if (this.head_icon) {
            Image(this.head_icon)
              .width(unit)
              .height(unit)
          }
          Text(this.text)
            .fontSize(unit)
            .fontColor(Color.White)
        }.id('content')
      }.width(this.content_len)
    }
  }
}

@Component
struct NormalButton {
  private text: string

  build() {
    Button(this.text)
      .type(ButtonType.Normal)
      .fontSize(UI_Config.normalFontSize)
      .fontWeight(FontWeight.Bold)
      .height(UI_Config.buttonHeight)
      .margin({right: UI_Config.containerMargin})
      .backgroundColor(UI_Config.SuccessColor)
      .borderRadius(UI_Config.buttonBorderRadius)
  }
}

export { Tag, NavContainer, SubPageNav, smallCapsule, PageNavWithMenu, NormalButton }