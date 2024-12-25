import { Card, PostCard } from './components/Cards'
import router from '@ohos.router'
import { UI_Config } from './config'

@Preview
@Component
struct Found {
  @State bg_color: string = '#ffffffff'
  @State fontColor: string = '#ffffffff'
  @State selectedFontColor: string = '#ff8de8ff'
  @State currentIndex: number = 0
  private tab_controller = new TabsController()


  // build the tapBar
  @Builder
  tabBar(index: number,
         title: string,
         offset: string = '',
         fontSize: number = 12,
         margin: string | number = UI_Config.containerPadding) {
    Column() {
      Column() {
        Text(title)
          .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
          .fontSize(fontSize)
          .fontWeight(this.currentIndex === index ? 800 : 400)

        if (this.currentIndex === index) {
          Rect()
            .width('100%')
            .height(2)
            .fill(this.selectedFontColor)
            .radius(1)
            .margin({ top: 5 })
        }
      }.width(40).onClick(() => {
        this.tab_controller.changeIndex(index)
      })
    }
    .width('100%')
    .height(30)
    .alignSelf(ItemAlign.Start)
    .margin({ left: margin })
    .offset({ x: offset })

  }

  @Builder
  WikiCard(title: string, content: string) {
    Card({border_width:1,border_color:UI_Config.PrimaryColor}) {
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(800)
          .fontColor('black')
          .margin({ top: 10, bottom: 10 })
        Text(content)
          .fontSize(14)
          .fontWeight(400)
          .fontColor(UI_Config.PrimaryColor)
          .margin({ bottom: 10 })
      }.width('100%').alignItems(HorizontalAlign.Start)
    }
  }

  build() {
    // 顶部导航
    Tabs({ barPosition: BarPosition.Start, controller: this.tab_controller }) {
      TabContent() {
        Scroll() {
          // 创建七个PostCard
          Column() {
            PostCard({ title: '这是一个标题' })
            ForEach([1, 2, 3, 4, 5, 6, 7], () => {
              PostCard()
            })
          }
        }
      }.tabBar(this.tabBar(0, '广场', '0', 16, 0))

      TabContent() {
        Scroll() {
          Column() {
            // Head
            Row() {
              Column({ space: 10 }) {
                // Main title & pic
                Row() {
                  Image($r('app.media.lock'))
                    .width(126)
                    .height(126)
                  Text('常见疾病一点通')
                    .fontSize(28)
                    .fontWeight(800)
                    .fontColor(UI_Config.PrimaryColor)
                }
                // Sub title
                Row() {
                  Text('多了解，多预防')
                    .fontSize(16)
                    .fontWeight(400)
                    .fontColor(UI_Config.PrimaryColor)
                }.padding(10).borderRadius(5).backgroundColor('#f5f5f5').alignSelf(ItemAlign.Start).margin({left:10})
              }
            }
            // WikiCard
            Column({ space: 10 }) {
              this.WikiCard('白血病是什么？', '白血病是一种白血细胞恶性增生的疾病，是由于骨髓造血组织中的幼稚白血细胞发生恶性增生，而抑制正常造血细胞的生成，从而引起全身性症状的一种疾病。')
              ForEach([1,2,3,4,5,6,7], () => {
                this.WikiCard('白血病是什么？', '白血病是一种白血细胞恶性增生的疾病，是由于骨髓造血组织中的幼稚白血细胞发生恶性增生，而抑制正常造血细胞的生成，从而引起全身性症状的一种疾病。')
              })
            }

          }
          .padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
          .width('100%')
          .backgroundColor('white')
        }
      }.tabBar(this.tabBar(1, '百科', '0', 16, 0))
    }.backgroundColor(UI_Config.PrimaryColor).onChange((index: number) => {
      this.currentIndex = index
    }).barHeight(UI_Config.navBarHeight - 6)
  }
}

export { Found }