import router from '@ohos.router'
import { NormalSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'
@Entry
@Component
struct NotificationSetting {
  @State @Watch('onback') clicked: boolean = false
  blue = UI_Config.PrimaryColor

  // set the padding style
  @Styles nPadding() {
    .padding({left:UI_Config.containerPadding, right:UI_Config.containerPadding})
  }

  onback() {
    router.back()
  }

  build() {
    Row() {
      Column({space: 10}) {
        Row() {
          SubPageNav({title: '通知设置', clicked: $clicked, bgColor: this.blue, fontColor: 'white'})
        }
        // About setting notification type
        Column(){
          Row() {
            Text('系统通知提醒')
              .fontSize(UI_Config.subTitleFontSize)
              .fontWeight('bold')
              .margin({bottom:5})
          }.width('100%').nPadding()

          Column({ space: 10 }) {
            NormalSection({ title: '通知显示消息摘要', type: 'switch' })
          }
        }
        // About setting notification sound
        Column(){
          Row() {
            Text('通知声音')
              .fontSize(UI_Config.subTitleFontSize)
              .fontWeight('bold')
              .margin({bottom:5})
          }.width('100%').nPadding()

          Column({ space: 10 }) {
            NormalSection({ title: '通知声音', type: 'switch' })
          }
        }
      }
      .width('100%')
    }.alignItems(VerticalAlign.Top)
    .height('100%')
  }
}