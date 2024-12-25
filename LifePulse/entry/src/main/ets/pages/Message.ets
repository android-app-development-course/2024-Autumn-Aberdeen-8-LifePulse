
import { NavContainer } from './components/utilites'
@Preview
@Component
struct Message {

  build() {
    Column() {
      // Head
      Row() {
        NavContainer() {
          Text("消息中心")
            .fontWeight(800)
        }
      }
      // Body
      Column() {

      }
    }
  }
}
