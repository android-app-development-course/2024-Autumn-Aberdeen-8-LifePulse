import router from '@ohos.router'
import { PostCard } from './components/Cards'
import { BigUserInfo } from './components/User'
import { SubPageNav } from './components/utilites'
import { UI_Config } from './config'
@Entry
@Component
struct UserDetailPage {
  @State @Watch('onBack') clicked: Boolean = false

  onBack(): void {
    router.back()
  }

  build() {
    Row() {
      Column() {
        Row() {
          SubPageNav({title: '', clicked: $clicked, bgColor: UI_Config.PrimaryColor, fontColor: '#fff'})
        }
        Row() {
          BigUserInfo({isOnMePage: false})
        }
        Row() {
          Text('动态')
            .fontWeight(600)
            .fontSize(20)
            .fontColor('#333')
            .margin({ top: 10, bottom: 10 })
            .alignSelf(ItemAlign.Start)
            .padding({ left: UI_Config.containerPadding})
        }.width('100%')
        Divider()
        Row() {
          Scroll() {
            Column() {
              ForEach([1, 2, 3, 4, 5, 6, 7], () => {
                PostCard()
              })
            }
          }
        }
      }
      .width('100%').alignSelf(ItemAlign.Start)

    }
    .height('100%')
  }
}