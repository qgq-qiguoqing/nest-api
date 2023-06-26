import {
  CanActivate,
  ExecutionContext,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { Request } from 'express';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { Reflector } from '@nestjs/core';
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';
@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private jwtService: JwtService,
    private configService: ConfigService,
    private reflector: Reflector,
  ) { }
  async canActivate(context: ExecutionContext): Promise<boolean> {
    console.log('isPublicisPublicisPublic');

    const isPublic = this.reflector.getAllAndOverride<boolean>('isPublic', [
      //即将调用的方法
      context.getHandler(),
      //controller类型
      context.getClass(),
    ]);
    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const token = this.extractTokenFromHeader(request);


    if (!token) throw new ApiException('token已失效', ApiErrorCode.USER_TOKEN);
    try {
      const payload = await this.jwtService.verifyAsync(token, {
        secret: this.configService.get('JWT_SECRET'),
      });
      request['user'] = payload;
    } catch (error) {
      throw new ApiException('token已失效', ApiErrorCode.USER_TOKEN);
    }

    return true;
  }
  private extractTokenFromHeader(request: any): string | undefined {
    // const [type, token] = request.headers.authorization?.split(' ') ?? [];
    // console.log(request.headers.authorization);

    return request.headers.token || '';
  }
}
