class User {
  private name: string
  private sex: string
  private age: number
  private avatar: Resource
  private location: string

  constructor(name: string, sex: string, avatar: Resource, location: string, age: number) {
    this.name = name
    this.sex = sex
    this.avatar = avatar
    this.location = location
    this.age = age
  }

  getName() {
    return this.name
  }

  getSex() {
    return this.sex
  }

  getAvatar() {
    return this.avatar
  }

  getLocation() {
    return this.location
  }

  getAge() {
    return this.age
  }
}

export {User}