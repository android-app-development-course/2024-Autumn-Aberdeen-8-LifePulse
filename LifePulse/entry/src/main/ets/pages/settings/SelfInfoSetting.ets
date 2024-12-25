import router from '@ohos.router'
import { photoPicker } from '../components/PhotoPicker'
import { AvatarSection, StateSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'

@Entry
@Component
struct SelfInfoSetting {
  @State message: string = 'Hello World'
  @State @Watch('onback') clicked: boolean = false
  @State sex: string = '男'
  @State curr_sex: number = 0
  @State body_height: string = '175cm'
  @State birthday: string = '1996-06-15'
  @State name: string = 'Sytles'

  onback() {
    router.back()
  }

  // Todo: get user info from server
  onPageShow() {
    if (router.getParams()){
      this.name = router.getParams()['name']
    }
  }

  private blue = UI_Config.PrimaryColor

  @Styles nPadding() {
    .padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Row() {
          SubPageNav({ title: '个人资料设置', clicked: $clicked, bgColor: this.blue, fontColor: 'white' })
        }
        // About setting notification type
        Column() {
          AvatarSection({ title: '头像', avatar: $r('app.media.avatar') })
            .onClick(() => {
              photoPicker()
            }
            )
          StateSection({ title: '昵称', state: this.name })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/settings/NameSetting',
                params: {
                  name: this.name
                }
              })
            })

          StateSection({ title: '性别', state: this.sex })
            .onClick(() => {
              TextPickerDialog.show({
                range: ['男', '女'],
                selected: this.sex === '男' ? 0 : 1,
                onAccept: (value) => {
                  this.sex = value.index === 0 ? '男' : '女'
                }
              })
            })

          StateSection({ title: '身高', state: this.body_height })
            .onClick(() => {
              TextPickerDialog.show({
                range: [...Array(100).keys()].map(i => i + 100)
                  .map(i => i.toString() + 'cm'), // ['100cm', '101cm', '102cm', ...
                selected: parseInt(this.body_height) - 100,
                onAccept: (value) => {
                  this.body_height = String(value.index + 100) + 'cm'
                }
              })
            })


          StateSection({ title: '生日', state: this.birthday })
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date('1900-01-01'),
                end: new Date(),
                selected: new Date(this.birthday),
                onAccept: (value) => {
                  this.birthday = String(value.year) + '-' + String(value.month+1) + '-' + String(value.day)
                }
              })
            })

        }
      }

    }
    .width('100%')
  }
}