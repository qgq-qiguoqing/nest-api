import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from "./entities/user.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';


@Injectable()
export class UserService {
  constructor(@InjectRepository(User) private userRepository: Repository<User>) { }
  async create(createUserDto: any) {
    const { email } = createUserDto;
    const existUser = await this.userRepository.findOne({
      where: { email },
    });

    if (existUser) {
      // throw new HttpException('用户已存在', HttpStatus.OK);

      throw new ApiException('用户已存在', ApiErrorCode.USER_NOTEXIST);
    }
    // throw new ApiException('用户已存在', ApiErrorCode.USER_EXIST);
    try {
      const newUser = await this.userRepository.create(createUserDto);
      return await this.userRepository.save(newUser);
    } catch (error) {
      throw new HttpException(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  async findAll() {
    return await this.userRepository.find()
  }

  async findOne(email: string) {
    const user = await this.userRepository.findOne({
      where: {
        email
      }
    })

    if (!user) throw new ApiException('用户名不存在', ApiErrorCode.USER_NOTEXIST);
    delete user.password

    return user;

  }

  async update(email: string, updateUserDto: UpdateUserDto) {

    return await this.userRepository.update({
      email
    }, {
      ...updateUserDto
    })
  }
  async getHead(email: string) {
    let usr = await this.userRepository.findOne({
      where: {
        email
      }
    })

    return {
      email: usr.email,
      name: usr.nickname,
      username: usr.username,
      avatar: usr.avatar
    }
  }
  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
