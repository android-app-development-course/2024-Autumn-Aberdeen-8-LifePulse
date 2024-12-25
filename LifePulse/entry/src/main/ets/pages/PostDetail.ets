import router from '@ohos.router'
import { CommentCard, PostCardInter } from './components/Cards'
import { NormalUserInfo } from './components/User'
import { SubPageNav, Tag } from './components/utilites'
import { UI_Config } from './config'

// const params = router.getParams()
// const postId = params['postId']

@Entry
@Component
struct PostDetail {
  @State @Watch('onback') clicked: Boolean = false

  onback(): void {
    router.back()
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      // nav
      SubPageNav({ title: '帖子详情', clicked: $clicked, bgColor:UI_Config.PrimaryColor, fontColor: '#fff' })
      // body
      Scroll() {
        Column() {
          Column({ space: 10 }) {
            // User info
            GridRow({ columns: 5 }) {
              GridCol({ span: 2 }) {
                NormalUserInfo().alignSelf(ItemAlign.Start)
              }

              GridCol({ offset: 1, span: 2 }) {
                Text('2月13日  23:36 发布')
                  .fontWeight(400)
                  .fontSize(14)
                  .fontColor('#666')
                  .offset({ y: 10 })
                  .alignSelf(ItemAlign.End)
              }
            }.width('100%').margin({ top: 10 })

            // title&content
            Column({ space: 5 }) {
              Column({ space: 5 }) {
                Text('骨髓增生异常综合征会有什么临床症状？')
                  .fontWeight(600)
                  .fontSize(16)
                  .fontColor('#333')
                Text('想问一下大家骨髓增生异常综合征的一些具体的表现呢？感觉自己有可能出现了类似的症状')
                  .fontWeight(400)
                  .fontSize(12)
                  .fontColor('#666')
              }.width('100%').alignItems(HorizontalAlign.Start)

              // content pic
              Image($r('app.media.sea'))
                .width(206)
                .height(146)
                .alignSelf(ItemAlign.Start)

              // tags
              Row() {
                Tag({ text: '骨髓增生异常综合征' })
              }.width('100%')
            }

            // post interaction
            GridRow({ columns: 4 }) {
              GridCol() {
                PostCardInter({ head_pic: $r('app.media.like'), num: 0 })
              }

              GridCol() {
                PostCardInter({ head_pic: $r('app.media.eye'), num: 0 })
              }

              GridCol() {
                PostCardInter({ head_pic: $r('app.media.share'), num: 0 })
              }

              GridCol() {
                PostCardInter({ head_pic: $r('app.media.comment'), num: 0 })
              }
            }
          }.padding({ left: 15, right: 15 })

          Divider().width('100%').height(1).color('#f0f0f0')

          // comments
          Column({ space: 5 }) {
            Text('评论')
              .fontWeight(600)
              .fontSize(20)
              .fontColor('#333')
              .margin({ top: 10, bottom: 10 })
              .alignSelf(ItemAlign.Start)
              .padding({ left: UI_Config.containerPadding})


            Column() {
              ForEach([1, 2, 3, 4, 5], (item) => {
                Divider().width('100%').height(1).color('#f0f0f0')
                CommentCard({ content: '不是很了解，但是建议去医院检查一下', like_num: 0 })
              })
            }
          }.width('100%')
        }

      }

      Column() {
        Divider().width('100%').height(1).color('#f0f0f0')
        Flex() {

          // user avatar
          Image($r('app.media.avatar'))
            .width(40)
            .height(40)
            .flexShrink(0)
            .clip(new Circle({ width: 40, height: 40 }))
            .margin(5)
            .alignSelf(ItemAlign.Center)

          // input
          Stack() {
            TextInput({ placeholder: '请输入评论内容' })
              .enterKeyType(EnterKeyType.Send)
              .placeholderFont({ size: 12 })
              .fontSize(12)
              .flexShrink(1)
              .height(30)
              .borderRadius(10)
              .margin({ left: 5, right: 5 })
              .padding({ left: 10, right: 10 })

            // emoji
            Column() {
              Image($r('app.media.emoji'))
                .width(20)
                .height(20)
                .flexShrink(0)
                .margin({ right: 10 })
                .alignSelf(ItemAlign.End)
            }.width('100%')
          }.alignSelf(ItemAlign.Center)

          // send
          Button('发送')
            .type(ButtonType.Normal)
            .fontColor('#fff')
            .backgroundColor('#007bff')
            .flexShrink(0)
            .width(60)
            .height(26)
            .borderRadius(10)
            .alignSelf(ItemAlign.Center)
        }.margin(10)
      }

    }.height('100%').width('100%')
  }

  pageTransition() {
    PageTransitionEnter({ duration: 200 }).onEnter((type: RouteType, progress: number) => {
      
    }).slide(SlideEffect.Right)
    PageTransitionExit({ duration: 200 }).onExit((type: RouteType, progress: number) => {

    }).slide(SlideEffect.Right)
  }
}