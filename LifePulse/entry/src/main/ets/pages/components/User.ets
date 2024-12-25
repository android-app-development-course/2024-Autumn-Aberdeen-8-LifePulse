import router from '@ohos.router'
import { User } from '../../models/auth'
import { UI_Config } from '../config'
import { smallCapsule } from './utilites'

// Create a test User
let user = new User('Sytles', 'male', $r('app.media.avatar'), '深圳市', 24)

@Extend(Text) function smallNumber() {
  .fontSize(10)
}

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

@Preview
@Component
struct NormalUserInfo {
  @State user: User = user
  @State bg_color: string = '#FFFFFF'
  @State hover_color: string = '#F0F0F0'
  @State normal_color: string = '#FFFFFF'


  // default gender background color
  private female_bg_color: string = '#FFC0CB'
  private male_bg_color: string = '#87CEFA'

  build() {
    Row({ space: 5 }) {
      // User avatar
      Image(this.user.getAvatar())
        .height(40)
        .width(40)
        .clip(new Circle({ width: 40, height: 40 }))


      Column() {

        // User name and age
        Row({ space: 5 }) {
          Text(this.user.getName())
            .fontSize(16)
            .fontWeight('bold')
            .baselineOffset(-2)
          if (this.user.getSex() === 'male') {
            smallCapsule({ text: '♂' + String(this.user.getAge()), bg_color: this.male_bg_color })
          } else {
            smallCapsule({ text: '♀' + String(this.user.getAge()), bg_color: this.female_bg_color })
          }
        }.alignItems(VerticalAlign.Center)

        // User location
        Row() {
          Text(this.user.getLocation())
            .fontSize(12)
            .fontColor('#808080')
        }.margin({ top: 2, bottom: 2 })
      }.alignItems(HorizontalAlign.Start)
    }
    .fancy_hover()
    .borderRadius(10)
    .backgroundColor(this.bg_color)
    .padding(5)
    .onClick(() => {
      console.info('click')
      router.pushUrl({
        url: 'pages/UserDetail',
        // params: {
        //   user: this.user
        // }
      })
    })
    .offset({ x: -5 })
  }
}

@Preview
@Component
struct BigUserInfo {
  // 是否是我的页面
  @State isOnMePage: boolean = true
  @State follow: boolean = false
  private padding_val: number = UI_Config.containerPadding

  build() {
    Column({ space: 10 }) {
      // 头部
      GridRow() {
        GridCol({ span: 10 }) {

          Row(){
            Row({ space: 10 }) {
              Row() {
                Stack() {
                  Shape() {
                    Circle({ width: 57, height: 57 })
                      .fill('white')
                  }

                  Shape() {
                    Circle({ width: 54, height: 54 })
                      .fill('#ffa0a0a0')
                  }

                  Image($r('app.media.avatar'))
                    .width(54)
                    .height(54)
                    .clip(new Circle({ width: 54, height: 54 }))
                }.alignSelf(ItemAlign.End)
              }.height('100%')

              // 用户名
              Row() {
                Stack() {
                  Text('Sytles')
                    .fontSize(20)
                    .fontColor('white')
                    .fontWeight('bold')
                }.align(Alignment.Start).height(57).alignSelf(ItemAlign.End)
              }.height('100%')
            }.onClick(() => {
              console.info('click')
              router.pushUrl({
                url: 'pages/settings/SelfInfoSetting'
              })
            })
          }.width('100%')

        }

        // 设置按钮
        if (this.isOnMePage) {
          GridCol({ span: 2 }) {
            Stack() {
              Image($r('app.media.setting_icon'))
                .width(20)
                .height(20)
                .offset({ y: 16, x: 20 }) // 偏移
                .onClick(() => {
                  console.info('setting')
                  router.pushUrl({
                    url: 'pages/settings/MainSetting'
                  })
                })
            }.height('100%')
            .align(Alignment.Top) // 顶部对齐
          }
        } else {
          // 关注按钮
          GridCol({ span: 2 }) {
            Flex() {
              Stack() {
                Button(this.follow === true? '已关注': '关注')
                  .width(70)
                  .height(30)
                  .borderRadius(15)
                  .fontColor('white')
                  .backgroundColor(this.follow === true? '#ff2058ff': '#ffabd4ff')
                  .offset({x:-20})
                  .onClick(() => {
                    this.follow = !this.follow
                  })
              }.height(57)
              .align(Alignment.Start).alignSelf(ItemAlign.End)
            }.height('100%')
          }
        }
      }.height(90)
      // 详细信息
      Row({ space: 10 }) {
        smallCapsule({ head_icon: $r('app.media.sex_icon'), bg_color: '#ff003dd7' })
        smallCapsule({ text: '20岁' })
        smallCapsule({ text: '深圳' })
      }.width('100%')
      // 粉丝数&关注数
      Row({ space: 10 }) {
        // 粉丝数
        Column() {
          Text('粉丝')
            .fontSize(12)
            .fontColor('#ffffffff')
          Text('100')
            .fontSize(15)
            .fontWeight('bold')
        }
        // 关注数
        Column() {
          Text('关注')
            .fontSize(12)
            .fontColor('#ffffffff')
          Text('100')
            .fontSize(15)
            .fontWeight('bold')
        }.alignItems(HorizontalAlign.Center)
      }.width('100%').margin({ bottom: 10 })
    }.backgroundColor('#ff1a8af3').width('100%').padding({ left: this.padding_val, right: this.padding_val })
  }
}

@Preview
@Component
struct MessageUserHead {
  private user: User = user

  build() {
    Row({ space: 10 }) {
      Image(this.user.getAvatar())
        .width(40)
        .height(40)
        .clip(new Circle({ width: 40, height: 40 }))
      Column() {
        Text(this.user.getName())
          .fontSize(16)
          .fontWeight('bold')
      }
    }
  }
}

export { NormalUserInfo, BigUserInfo, MessageUserHead }