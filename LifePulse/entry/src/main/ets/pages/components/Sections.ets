import { User } from '../../models/auth'
import { UI_Config } from '../config'
import { MessageUserHead } from './User'
import { NavContainer } from './utilites'

// Create a test User
let user = new User('Sytles', 'male', $r('app.media.avatar'), '深圳市', 24)

@Styles function fancy_hover() {
  .onTouch(
    (event) => {
      if (event.type === TouchType.Down && this.untouchable === false) {
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
struct BaseSectionContainer {
  @BuilderParam children: () => void
  private normal_color: string | Resource = 'white'
  private hover_color: string | Resource = '#f0f0f0'
  private divider_color: string | Resource = 'rgba(247, 247, 247, 0.15)'
  @State bg_color: string = 'white'
  private untouchable: boolean = false

  @Builder fancy_divider() {
    Divider()
      .height(1)
      .width('100%')
      .backgroundColor(this.divider_color)
      .opacity(0.5)
  }

  build() {
    Column({ space: 10 }) {
      this.fancy_divider()
      this.children()
      this.fancy_divider()
    }.backgroundColor(this.bg_color).fancy_hover()
  }
}

@Component
struct NormalSection {
  private head_icon: Resource
  private font_color: string
  private title: string = "Title"
  private normal_color: string = 'white'
  private hover_color: string = '#f0f0f0'
  @State untouchable: boolean = false
  private type: string = 'entry'

  build() {
    BaseSectionContainer({
      untouchable: this.untouchable,
      normal_color: this.normal_color,
      hover_color: this.hover_color
    }) {
      Stack() {

        Row({ space: 10 }) {
          // icon
          if (this.head_icon) {
            Stack() {
              Image(this.head_icon)
                .height(24)
                .width(24)
                .fillColor('black')
            }
          }
          // Title
          Stack() {
            Text(this.title)
              .fontColor(this.font_color)
              .fontSize(16)
              .baselineOffset(-2)
          }.width(this.type === 'center' ? '100%' : 'auto')
        }.width('100%').padding({ left: UI_Config.containerPadding })

        if (this.type === 'entry') {
          // Arrow
          Stack() {
            Row() {
              Image($r('app.media.simple_arrow'))
                .width(22)
                .height(22)
            }.alignItems(VerticalAlign.Center)
          }.align(Alignment.End).width('100%').padding({ right: UI_Config.containerPadding })
        } else if (this.type === 'switch') {
          // Switch
          Stack() {
            Row() {
              Toggle({ type: ToggleType.Switch, isOn: false })
                .selectedColor(UI_Config.PrimaryColor)
                .switchPointColor('white')
            }.height(24)
          }.align(Alignment.End).width('100%').padding({ right: UI_Config.containerPadding })

        }
      }
      .width('100%')
    }
  }
}


@Component
struct StateSection {
  @Prop state: string
  private font_color: string
  @State title: string = "Title"
  @State normal_color: string = 'white'
  @State hover_color: string = '#f0f0f0'
  @State untouchable: boolean = false

  build() {
    BaseSectionContainer({
      untouchable: this.untouchable,
      normal_color: this.normal_color,
      hover_color: this.hover_color
    }) {
      Stack() {
        Row() {
          Text(this.title)
            .fontColor(this.font_color)
            .fontSize(16)
            .baselineOffset(-2)
        }.width('100%').padding({ left: UI_Config.containerPadding })
        // State
        Row() {
          Text(this.state)
            .fontColor(UI_Config.SecondaryColor)
            .fontSize(UI_Config.smallFontSize)
            .baselineOffset(-2)
          // Arrow
          Image($r('app.media.simple_arrow'))
            .width(22)
            .height(22)
        }.alignItems(VerticalAlign.Center)
      }.align(Alignment.End).width('100%').padding({ right: UI_Config.containerPadding })
    }
  }
}

@Component
struct AvatarSection {
  private avatar: Resource
  private font_color: string
  @State title: string = "Title"
  @State normal_color: string = 'white'
  @State hover_color: string = '#f0f0f0'
  @State untouchable: boolean = false

  build() {
    BaseSectionContainer({
      untouchable: this.untouchable,
      normal_color: this.normal_color,
      hover_color: this.hover_color
    }) {
      Stack() {
        // Title
        Row() {
          Text(this.title)
            .fontColor(this.font_color)
            .fontSize(16)
            .baselineOffset(-2)
        }.width('100%').padding({ left: UI_Config.containerPadding })
        // State
        Row() {
          // Avatar
          Image(this.avatar)
            .width(54)
            .height(54)
            .clip(new Circle({ width: 54, height: 54 }))
          // Arrow
          Image($r('app.media.simple_arrow'))
            .width(22)
            .height(22)
        }.alignItems(VerticalAlign.Center)
      }.align(Alignment.End).width('100%').padding({ right: UI_Config.containerPadding })
    }
  }
}

@Component
struct TextInputSection {
  @Link value: string
  private placeholder: string
  private title: string
  private font_color: string
  private normal_color: string
  private hover_color: string
  private type: string

  build() {
    Column({ space: 10 }){
      if (this.title) {
        Text(this.title)
          .fontColor(this.font_color)
          .fontSize(UI_Config.subTitleFontSize)
          .fontWeight(FontWeight.Bold)
          .baselineOffset(-2)
          .padding({ left: UI_Config.containerPadding })
      }
      BaseSectionContainer({
        untouchable: true,
        normal_color: this.normal_color,
        hover_color: this.hover_color,
      }) {
        Row() {
          TextInput({ text: this.value, placeholder: this.placeholder })
            .placeholderColor(UI_Config.SecondaryColor)
            .onChange((value) => this.value = value)
            .style(TextInputStyle.Inline)
            .borderRadius(0)
            .backgroundColor('white')
            .padding(0)
            .type(this.type === 'password' ? InputType.Password : InputType.Normal)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
      }
    }.alignItems(HorizontalAlign.Start)
  }
}

@Preview
@Component
struct MessageSection {
  private user: User = user
  @State recent_message: string = 'Hello World'
  @State time: string = '1分钟前'
  @State unread_count: number = 1

  build() {
    BaseSectionContainer() {
      Column() {
        Row(){
          MessageUserHead({ user: this.user})
          Text(this.time)
            .fontColor(UI_Config.SecondaryColor)
            .fontSize(UI_Config.smallFontSize)
            .baselineOffset(-2)
        }.width('100%')
      }.padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
    }
  }
}

export { NormalSection, StateSection, AvatarSection, TextInputSection }