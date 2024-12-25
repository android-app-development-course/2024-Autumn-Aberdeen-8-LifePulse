import { PostCard } from './components/Cards'
import { NormalSection } from './components/Sections'
import { BigUserInfo } from './components/User'
import { smallCapsule } from './components/utilites'
import { UI_Config } from './config'


@Preview
@Component
struct Me {
  @State currentIndex: number = 0
  private fontColor: string = '#666'
  private selectedFontColor: string = '#333'
  private tab_controller = new TabsController()

  // build the tapBar
  @Builder
  tabBar(index: number, title: string, offset: string = '') {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(12)
        .fontWeight(this.currentIndex === index ? 600 : 400)
        .lineHeight(14)
      if (this.currentIndex === index) {
        Rect()
          .width('100%')
          .height(2)
          .fill('#333')
          .radius(1)
          .margin({ top: 5 })
      }
    }
    .width(30)
    .height(20)
    .alignSelf(ItemAlign.Start)
    .margin({ left: UI_Config.containerPadding })
    .offset({ x: offset })
    // change the tab when clicked
    .onClick(() => {
      this.tab_controller.changeIndex(index)
    })
  }

  build() {
    Column() {
      BigUserInfo({ isOnMePage: true })

      Tabs({ barPosition: BarPosition.Start, controller: this.tab_controller }) {
        TabContent() {
          Column() {
            NormalSection({ head_icon: $r('app.media.star'), title: '血液检测记录' })
            NormalSection({ head_icon: $r('app.media.star'), title: '血压记录' })
            NormalSection({ head_icon: $r('app.media.star'), title: '心率记录' })
            NormalSection({ head_icon: $r('app.media.star'), title: '体重记录' })
            NormalSection({ head_icon: $r('app.media.star'), title: '血糖记录' })
          }
        }.tabBar(this.tabBar(0, '记录')).align(Alignment.Top)

        TabContent() {
          Column() {
            Divider()
            Scroll() {
              Column() {
                ForEach([1, 2, 3, 4, 5, 6, 7], () => {
                  PostCard()
                })
              }
            }
          }
        }.tabBar(this.tabBar(1, '动态', '-70%')).align(Alignment.Top)
      }
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .barHeight(40)
      .layoutWeight(1) // make the tab content fill the rest space
    }.width('100%').height('100%')
  }
}


export { Me }