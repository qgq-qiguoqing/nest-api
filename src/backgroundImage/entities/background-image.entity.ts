import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
@Entity('background')
export class BackgroundImage {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty({
        description: '图片地址'
    })
    @Column()
    url: string

    @ApiProperty({
        description: '是否启用'
    })
    @Column({ default: false })
    isEnable: boolean

    @ApiProperty({
        description: "创建时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    createTime: Date;

    @ApiProperty({
        description: "用户邮箱"
    })
    @Column()
    userEmail: string
}
