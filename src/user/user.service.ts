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
  async create(createUserDto: CreateUserDto) {
    const { username } = createUserDto;
    const existUser = await this.userRepository.findOne({
      where: { username },
    });

    if (existUser) {

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

  async findOne(username: string) {
    const user = await this.userRepository.findOne({
      where: {
        username
      }
    })
    if (!user) throw new HttpException('用户名不存在', HttpStatus.BAD_REQUEST);
    return user;

  }

  async update(id: number, updateUserDto: UpdateUserDto) {

    return await this.userRepository.update({
      id
    }, {
      ...updateUserDto
    })
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
