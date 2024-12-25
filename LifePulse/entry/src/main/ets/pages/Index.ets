import { HomePage } from './Home'
import { Found } from './Found'
import { Me } from './Me'
import { UI_Config } from './config'
import display from '@ohos.display'
import window from '@ohos.window'
import router from '@ohos.router'

@Entry
@Component
struct SearchExample {
  @State currentIndex: number = 0
  @State fontColor: string = '#666666'
  @State selectedFontColor: string = UI_Config.PrimaryColor
  @State display: display.Display = display.getDefaultDisplaySync()

  // TabBar Builder
  @Builder TabBar(index: number, activated_pic: Resource, unactivated_pic: Resource, title: string, offset: string) {
    Column() {
      Image(this.currentIndex === index ? activated_pic : unactivated_pic)
        .width(26)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(title)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.offset({ x: offset })
  }

  build() {
    // 导航栏
    Stack() {
      Tabs({ barPosition: BarPosition.End }) {

        // 首页内容
        TabContent() {
          HomePage()
        }
        .tabBar(this.TabBar(0, $r('app.media.antoutline_home'), $r('app.media.outline_home'), '首页', '-2.5%'))

        TabContent() {
          Found()
        }
        .tabBar(this.TabBar(1, $r('app.media.antoutline_compass'), $r('app.media.outline_compass'), '发现', '-10%'))


        TabContent() {
          Text('收到的消息').fontSize(30)
        }
        .tabBar(this.TabBar(2, $r('app.media.antoutline_message'), $r('app.media.outline_message'), '消息', '10%'))

        TabContent() {
          Me()
        }
        .tabBar(this.TabBar(3, $r('app.media.antoutline_user'), $r('app.media.outline_user'), '我的', '2.5%'))
      }.onChange((index: number) => {
        this.currentIndex = index
      }).animationDuration(100)

      Row() {
        Image($r('app.media.CirclePlus'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/PostEdit'
            })
          })
      }.height('100%').alignItems(VerticalAlign.Bottom).offset({ y: -23 })
    }

  }
}
