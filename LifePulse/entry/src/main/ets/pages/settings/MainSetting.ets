import router from '@ohos.router'
import { NormalSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'
@Entry
@Component
struct Settings {
  @State @Watch('onback') clicked: boolean = false
  blue = UI_Config.PrimaryColor

  onback() {
    router.back()
  }

  build() {
    Row() {
      Column({space: UI_Config.columnSpace}) {
        Row() {
          SubPageNav({title: '设置', clicked: $clicked, bgColor: this.blue, fontColor: 'white'})
        }
        // About account
        Row() {
          Column() {
            NormalSection({title: '个人资料编辑'})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/settings/SelfInfoSetting'
                })
              })
            NormalSection({title: '账号与安全'})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/settings/AccountSetting'
                })
              })
          }
        }
        // About app
        Row() {
          Column() {
            NormalSection({title: '通知设置'})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/settings/NotificationSetting'
                })
              })
            NormalSection({title: '隐私'})
            NormalSection({title: '关于'})
          }
        }
        // Logout
        Row() {
          Column() {
            NormalSection({title: '退出登录', type: 'center', font_color: 'red'})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/Logout'
                })
              })
          }
        }
      }
      .width('100%')
    }.alignItems(VerticalAlign.Top)
    .height('100%')
  }
}