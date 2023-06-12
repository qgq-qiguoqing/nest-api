import {
    Column,
    Entity,
    PrimaryGeneratedColumn,
    BeforeInsert,
    BeforeUpdate,
} from 'typeorm';
import encry from '../../utils/crypto';
import * as crypto from 'crypto';
import { ApiProperty } from '@nestjs/swagger';
@Entity('user')
export class User {
    @BeforeInsert()
    beforeInsert() {
        this.salt = crypto.randomBytes(4).toString('base64');
        this.password = encry(this.password, this.salt);
    }

    @PrimaryGeneratedColumn()
    id: number; // 标记为主键，值自动生成
    @ApiProperty({
        description: "用户名"
    })
    @Column({ length: 30 })
    username: string; //用户名

    @ApiProperty({
        description: "昵称"
    })
    @Column({ nullable: true })
    nickname: string; //昵称

    @ApiProperty({
        description: "密码"
    })
    @Column()
    password: string; //密码
    @Column({ nullable: true })

    @ApiProperty({
        description: "头像"
    })
    avatar: string; //头像
    @Column({ nullable: true })

    @ApiProperty({
        description: "邮箱"
    })
    email: string; //邮箱
    @Column({ nullable: true })

    @ApiProperty({
        description: "角色"
    })
    role: string; //角色
    @Column({ nullable: true })
    salt: string;

    @ApiProperty({
        description: "注册时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    create_time: Date;

    @ApiProperty({
        description: "更新时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    update_time: Date;



}

