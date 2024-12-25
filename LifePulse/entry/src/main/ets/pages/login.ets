import { HeadTextInput } from './components/HeadTextInput'
import router from '@ohos.router';

@Entry
@Component
struct Login {
  build() {
    Row() {
      Flex() {
        Column({ space: 20 }) {
          Row({ space: 20 }) {
            Text('血液医生')
              .fontColor('black')
              .fontSize(28)
              .fontWeight('bold')
              .offset({ y: -50 })
            Image($r('app.media.v2_s7ae48'))
              .width(181)
          }
          .alignItems(VerticalAlign.Bottom)

          HeadTextInput({ holder_text: '输入邮箱/手机号', head_pic: $r('app.media.ze_manager') })
          HeadTextInput({
            holder_text: '输入密码',
            head_pic: $r('app.media.if_ui_password'),
            inputtype: InputType.Password
          })
          Button('登录')
            .backgroundColor('#377F7F')
            .fontColor('black')
            .opacity(0.6)
            .width(154)
            .height(55)
            .border({ width: 1, color: '#BBBBBB' })
          Row() {
            Text('尚未注册？')
              .fontColor('black')
              .fontSize(14)
            Text('点击注册')
              .fontColor('blue')
              .fontSize(14)
              .onClick((event: ClickEvent) => {
                router.pushUrl({
                  url: 'pages/register'
                }, router.RouterMode.Single)
              })
          }

          Text('忘记密码')
            .fontColor('blue')
            .fontSize(14)
          Text('登录/注册表示您同意《用户协议》和《隐私政策》')
            .fontSize(13)
            .offset({ y: 100 })
        }

      }.align(Alignment.BottomStart)
      .padding({ right: 30, left: 30 })
      .width('100%')
    }
    .height('100%')
  }
}