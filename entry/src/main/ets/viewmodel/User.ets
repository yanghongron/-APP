export default class User {
  /**
   * 用户ID
   */
  id: number

  /**
   * 用户账号
   */
  username: string

  /**
   * 用户密码
   */

  password: string

  constructor(id: number, username: string, password: string) {
    this.id = id
    this.username = username
    this.password = password
  }
}