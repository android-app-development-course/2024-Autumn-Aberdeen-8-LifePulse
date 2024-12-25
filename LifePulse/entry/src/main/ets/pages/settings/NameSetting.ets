import router from '@ohos.router'
import { NormalSection, TextInputSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'

@Entry
@Component
struct Settings {
  @State @Watch('onback') clicked: boolean = false
  @State name: string = ''
  blue = UI_Config.PrimaryColor

  onback() {
    router.back()
  }

  onPageShow() {
    this.name = router.getParams()['name']
  }

  build() {
    Row() {
      Column({ space: UI_Config.columnSpace }) {
        Stack() {
          SubPageNav({ title: '昵称设置', clicked: $clicked, bgColor: this.blue, fontColor: 'white' })
          Button('保存')
            .type(ButtonType.Normal)
            .fontSize(UI_Config.normalFontSize)
            .fontWeight(FontWeight.Bold)
            .height(UI_Config.buttonHeight)
            .margin({right: UI_Config.containerMargin})
            .backgroundColor(UI_Config.SuccessColor)
            .borderRadius(UI_Config.buttonBorderRadius)
            .onClick(() => {
              router.back({
                url: 'pages/settings/SelfInfoSetting',
                params: {
                  name: this.name
                }
              })
            })
        }.alignContent(Alignment.End)
        // About account
        TextInputSection({ value: $name })
      }
      .width('100%')
    }.alignItems(VerticalAlign.Top)
    .height('100%')
  }
}