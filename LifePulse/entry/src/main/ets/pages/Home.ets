import { NormalButton } from './components/Buttons'
import { Card } from './components/Cards'
import { UI_Config } from './config'

@Extend(Text) function smallTitle() {
  .fontSize(16)
  .fontWeight(600)
  .alignSelf(ItemAlign.Start)
}

@Extend(Text) function normalText() {
  .fontSize(14)
  .fontWeight(400)
}

@Extend(Text) function normalBoldText() {
  .fontSize(14)
  .fontWeight(600)
}

@Extend(Image) function smallIcon() {
  .height(16)
  .width(16)
}

//滑块试图容器数据源类
class MyDataSource implements IDataSource {
  private list: number[] = []
  private listener: DataChangeListener

  constructor(list: number[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}

@Preview
@Component
struct HomePage {
  // 搜索栏内容变量
  @State inputValue: string = ''
  // 点击搜索后传递到的变量
  @State getValue: string = ''
  // 搜索栏控制器
  controller: SearchController = new SearchController()

  // 轮播组件控制器
  private swiperController: SwiperController = new SwiperController()
  // 轮播数据源
  private data: MyDataSource = new MyDataSource([])
  //
  images:Resource[]=[$r('app.media.heartbeat'), $r('app.media.stethoscope'), $r('app.media.balanceOne'), $r('app.media.medicalFiles'), $r('app.media.streetView')]
  // 处理轮播数据
  aboutToAppear(): void {
    let list = []
    for (var i = 1; i <= 10; i++) {
      list.push(i.toString());
    }
    this.data = new MyDataSource(list)
  }

  titles: string[] = ['血压', '心率', '体重', '血糖', '冥想']
  pics: Resource[] = [$r('app.media.heartbeat'), $r('app.media.stethoscope'), $r('app.media.balanceOne'), $r('app.media.medicalFiles'), $r('app.media.streetView')]
  bloodPressure_info = {
    '收缩压': '120 mmHg',
    '舒张压': '76 mmHg',
    '状态': '正常',
    '本周平均': '118/78 mmHg'
  }
  heartbeat_info = {
    '心率': '78 bpm',
    '状态': '正常',
    '本周平均': '78 bpm'
  }
  yCardHeight: number = 160
  xCardHeight: number = 80

  build() {
    // 整个页面为从上到下的多行，故采用列组件
    Column({ space: 10 }) {

      // 搜索栏
      Row() {
        Search({ value: this.inputValue, placeholder: '在此进行搜索...', controller: this.controller })
          .searchButton('搜索')
          .width('100%')
          .height(px2vp(vp2px(UI_Config.navBarHeight)-48)-5)
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
            // 当搜索被按下时执行
          .onSubmit((value: string) => {
            this.getValue = value
          })
      }.backgroundColor(UI_Config.PrimaryColor).padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })

      // 内容
      Column({space:5}) { // 轮播图
        // Swiper(this.swiperController) {
        //   LazyForEach(this.data, (item: string) => {
        //     Text(item)
        //       .width('100%')
        //       .height(160)
        //       .backgroundColor(0xAFEEEE)
        //       .textAlign(TextAlign.Center)
        //       .fontSize(30)
        //   }, item => item)
        // }
        // .cachedCount(2)
        // .index(1)
        // .autoPlay(true)
        // .interval(4000)
        // .indicator(true)
        // .loop(true)
        // .duration(1000)
        // .itemSpace(0)
        // .curve(Curve.Linear)
        // .onChange((index: number) => {
        //   console.info(index.toString())
        // })
        Column({space:5}) { // 轮播图
          Swiper(this.swiperController) {
            // ForEach(this.images, (item: Resource) => {
            //   Image(item)
            //     .width('100%')
            //     .height(160)
            // }, item => item)
            Image($r('app.media.swiper1'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper2'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper4'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper5'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper7'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper8'))
              .width('100%')
              .height(160)
            Image($r('app.media.swiper9'))
              .width('100%')
              .height(160)
          }
          .cachedCount(2)
          .index(1)
          .autoPlay(true)
          .interval(4000)
          .indicator(true)
          .loop(true)
          .duration(1000)
          .itemSpace(0)
          .curve(Curve.Linear)
          .onChange((index: number) => {
            console.info(index.toString())
          })
        }
        // 分栏
        Flex() {
          ForEach(this.titles, (title: string, index: number) => {
            Stack() {
              NormalButton({ title: title, pic: this.pics[index] })
            }.flexGrow(1)
          }, (title: string) => title)
        }

        // 数据展示1
        Column() {
          Flex() {
            Card({ normal_color: "#4095E5", hover_color: "#ff1f70bc", flexRatio: 1, cardHeight: this.yCardHeight }) {
              Column({ space: 7 }) {
                Row({ space: 10 }) {
                  Text('今日血压')
                    .smallTitle()
                    .fontColor(Color.White)
                  Image($r('app.media.neural'))
                    .smallIcon()
                }.alignSelf(ItemAlign.Start)

                ForEach(Object.keys(this.bloodPressure_info), (key: string, index: number) => {
                  // 如果key为收缩压或舒张压
                  if (key === '收缩压' || key === '舒张压') {
                    Text(key + ': ' + this.bloodPressure_info[key])
                      .fontColor("#333333")
                      .normalBoldText()
                  }
                  // 如果key为状态
                  if (key === '状态') {
                    // 如果状态为正常
                    if (this.bloodPressure_info[key] === '正常') {
                      Text(key + ': ' + this.bloodPressure_info[key])
                        .fontColor("#ff64ff79")
                        .normalBoldText()
                    } else {
                      Text(key + ': ' + this.bloodPressure_info[key])
                        .fontColor("#FF0000")
                        .normalBoldText()
                    }
                  }

                }, (key: string) => key)
                Text('本周平均:')
                  .fontColor(Color.White)
                  .smallTitle()
                Text('118/78 mmHg')
                  .fontColor("#333333")
                  .normalBoldText()
              }.flexGrow(1).alignSelf(ItemAlign.Center)
            }

            Card({ normal_color: "#377f7f", hover_color: "#ff276060", flexRatio: 1, cardHeight: this.yCardHeight }) {
              Column({ space: 7 }) {
                Row({ space: 10 }) {
                  Text('心率')
                    .smallTitle()
                    .fontColor(Color.White)
                  Image($r('app.media.love'))
                    .smallIcon()
                }.alignSelf(ItemAlign.Start)

                Text('每分钟跳动次数：')
                  .fontColor("#333333")
                  .normalBoldText()
                Text('78 bpm')
                  .fontColor("#333333")
                  .normalBoldText()
                Text('状态:正常')
                  .fontColor("#ff64ff79")
                  .normalBoldText()
                Text('本周平均:')
                  .fontColor(Color.White)
                  .smallTitle()
                Text('78 bpm')
                  .fontColor("#333333")
                  .normalBoldText()
              }.flexGrow(1).alignSelf(ItemAlign.Center)
            }

          }

          // 数据展示2
          Column() {
            Card({ normal_color: "#54BCBD", hover_color: "#ff378c8d", cardHeight: this.xCardHeight }) {
              Flex() {
                Column({ space: 5 }) {
                  Text('BMI指数')
                    .smallTitle()
                    .fontColor(Color.White)
                  Text('19.1')
                    .normalBoldText()
                    .fontColor('#333333')
                }.flexGrow(1)

                Column({ space: 5 }) {
                  Text('今日体重')
                    .smallTitle()
                    .fontColor(Color.White)
                  Text('62.7kg')
                    .normalBoldText()
                    .fontColor('#333333')
                }.flexGrow(1)
              }
            }

            // 下2
            Card({ normal_color: "#F9A825", hover_color: "#ffc1851b", cardHeight: this.xCardHeight }) {
              Flex() {
                Column({ space: 5 }) {
                  Text('今日血糖')
                    .smallTitle()
                    .fontColor(Color.White)
                  Text('空腹: 6.26mmol/L')
                    .normalBoldText()
                    .fontColor('#333333')
                  Text('餐后: 7.2mmol/L')
                    .normalBoldText()
                    .fontColor('#333333')
                }.flexGrow(1)

                Column({ space: 5 }) {
                  Text('状态:偏高')
                    .normalBoldText()
                    .fontColor(Color.Red)
                }.flexGrow(1).alignSelf(ItemAlign.Center)
              }
            }

          }
        }
      }.padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
    }.height('100%')
  }
}

export { HomePage }