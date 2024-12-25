import { HeadTextInput } from './components/HeadTextInput'

@Entry
@Component
struct Register {
  build() {
    Column({ space: 5 }) {
      Image($r('app.media.HeadPic2'))
        .width(200)
        .height(200)
        .offset({ x: -100, y: -10 })
      Column({ space: 20 }) {
        Text('用户注册')
          .fontColor('black')
          .fontSize(28)
          .fontWeight('bold')

        HeadTextInput({ head_pic: $r('app.media.phone'), holder_text: '请输入您的手机号' })
        HeadTextInput({ head_pic: $r('app.media.email'), holder_text: '请输入您的邮箱' })
        HeadTextInput({ head_pic: $r('app.media.lock'), holder_text: '请输入您的密码', inputtype: InputType.Password })
        HeadTextInput({
          head_pic: $r('app.media.lock'),
          holder_text: '请再次输入您的密码',
          inputtype: InputType.Password
        })

        Stack() {
          HeadTextInput({ head_pic: $r('app.media.security'), holder_text: '请输入您收到的验证码' })
          Button('发送')
            .backgroundColor('#1C98EA')
            .fontColor('white')
            .width(80)
            .height(30)
            .offset({ x: 100 })
        }

        Button('注册')
          .backgroundColor('#377F7F')
          .fontColor('black')
          .opacity(0.6)
          .width(154)
          .height(55)
          .border({ width: 1, color: '#BBBBBB' })
      }.offset({ y: -40 })

      Text('登录/注册表示您同意《用户协议》和《隐私政策》')
        .fontSize(13)
        .offset({ y: 70 })

    }.width('100%').height('100%').padding({ left: 20, right: 20 })
  }
}
