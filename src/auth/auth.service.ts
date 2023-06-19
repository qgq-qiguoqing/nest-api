import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserService } from 'src/user/user.service';
// import { LoginAuthDto } from './dto/login-auth.dto';
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';
import encry from '../utils/crypto'
@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) { }
  async login(loginAuthDto: any) {
    const { email, password } = loginAuthDto;

    const user = await this.userService.findOne(email);
    if (user?.password !== encry(password, user.salt)) {
      throw new ApiException('密码错误', ApiErrorCode.USER_NOTEXIST);
    }
    const payload = { username: user.email, sub: user.id };
    let token = await this.jwtService.signAsync(payload);
    delete user.password
    return {
      token,
      ...user
    }
  }



  create(createAuthDto: CreateAuthDto) {
    return 'This action adds a new auth';
  }

  findAll() {
    return `This action returns all auth`;
  }

  findOne(username: string) {
    return `This action returns a #${username} auth`;
  }

  update(id: number, updateAuthDto: UpdateAuthDto) {
    return `This action updates a #${id} auth`;
  }

  remove(id: number) {
    return `This action removes a #${id} auth`;
  }

}
