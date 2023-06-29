import { Controller, Get, Post, Body, Patch, Param, Delete, HttpCode } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto'

import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { Public } from 'src/public/public.decorator';
type userId = {
  userEmail: string
}
interface updateUser extends UpdateUserDto {
  id: string | number
  userEmail: string;
  avatar: string
}
class regDto {
  @ApiProperty({ description: '邮箱' })
  userEmail: string
  @ApiProperty({ description: '用户名' })
  username: string;

  @ApiProperty({ description: '密码' })
  password: string;

  @ApiProperty({ description: '头像' })
  avatar: string
}
class findDto {
  @ApiProperty({ description: '用户id' })
  id: string
}

@Controller('user')
@ApiTags('User')
export class UserController {
  constructor(private readonly userService: UserService) { }

  @ApiOperation({ summary: '用户注册' })
  @ApiBody({ type: regDto, description: '注册信息' })
  @ApiOkResponse({ description: 'Return all cats', type: [regDto] })
  @Public()
  @Post('/reg')
  @HttpCode(200)
  create(@Body() createUserDto: CreateUserDto) {
    console.log(createUserDto);

    return this.userService.create(createUserDto);
  }

  @ApiOperation({ summary: '查询所有用户' })
  @ApiOkResponse({ description: 'Return all cats', type: [regDto] })
  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @ApiOperation({ summary: '查询用户' })
  @ApiBody({ type: findDto, description: '根据用户邮箱' })
  @Post('/getUser')
  @HttpCode(200)
  findOne(@Body() para: userId) {
    return this.userService.findOne(para.userEmail);
  }


  @Post('/updateUser')
  @HttpCode(200)
  update(@Body() updateUserDto: updateUser) {
    let userEmail = updateUserDto.userEmail
    delete updateUserDto.id
    delete updateUserDto.userEmail
    if (!updateUserDto.password) {
      delete updateUserDto.password
    }
    console.log(updateUserDto)
    return this.userService.update(userEmail, updateUserDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.userService.remove(+id);
  }
}
