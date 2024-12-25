import router from '@ohos.router'
import { PostEditCard } from './components/Cards'
import { TextInputSection } from './components/Sections'
import { NormalButton, PageNavWithMenu, SubPageNav } from './components/utilites'
import { UI_Config } from './config'

@Entry
@Component
struct PostEdit {
  @State message: string = 'Hello World'
  @State @Watch('onBack') clicked: Boolean = false
  @State selected_index: number = 0
  @State post_title: string = ''
  @State text_content: string = ''
  @State image_uris: string[] = ['']
  menu_titles = ['帖子 ▾', '血液样本 ▾']
  menu_items = ['帖子', '血液样本']

  onBack() {
    router.back()
  }

  @Builder
  TextPostEditor() {
    Column({ space: 10 }) {
      PostEditCard({
        title: $post_title,
        text_content: $text_content,
        image_content_uris: $image_uris
      })
      TextInput({ placeholder: 'tags' })
        .height(40)
    }.padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Stack() {
          PageNavWithMenu({
            clicked: $clicked,
            bgColor: UI_Config.PrimaryColor,
            fontColor: 'white',
            selected: $selected_index,
            menuItems: this.menu_items,
            menuTitles: this.menu_titles
          })
            NormalButton({ text: '发布' })
        }.alignContent(Alignment.End)
      }
      .width('100%')

      if (this.selected_index == 0) {
        this.TextPostEditor()
      }
    }
    .height('100%')
  }
}