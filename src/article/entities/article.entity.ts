import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { Classification } from '../../classification/entities/classification.entity';
@Entity('article')
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty({
        description: "标题"
    })
    @Column({ length: 1000 })
    title: string;

    @ApiProperty({
        description: "text"
    })
    @Column("longtext") // 使用 LONGTEXT 类型存储较长的文本数据
    content: string;

    @ApiProperty({
        description: "创建时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    createTime: Date;
    @ApiProperty({
        description: "更新时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    update_time: Date;

    @ApiProperty({
        description: "作者"
    })
    @Column()
    author: string;
    @ApiProperty({
        description: "作者邮箱"
    })
    @Column()
    authorEmail: string;

    // @ApiProperty({
    //     description: "文章封面图片"
    // })
    // @Column()
    // coverPhoto: string

    @ApiProperty({
        description: "分类ID"
    })
    @Column()
    nameID: string

    @ManyToOne(() => Classification, classification => classification.articles)
    @JoinColumn({ name: 'id' })
    classification: Classification;

    @ApiProperty({
        description: "分类"
    })
    @Column()
    name: string



    // 可以添加其他属性，如文章封面图片等

    //   constructor(title: string, content: string, date: Date, author: string) {
    //     this.title = title;
    //     this.content = content;
    //     this.date = date;
    //     this.author = author;
    //   }
}