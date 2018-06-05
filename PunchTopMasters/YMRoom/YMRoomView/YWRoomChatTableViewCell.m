//
//  YWRoomChatTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/12.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomChatTableViewCell.h"
#import "EaseEmotionEscape.h"
@interface YWRoomChatTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *messageLable;

@end
@implementation YWRoomChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.messageLable.textColor = [UIColor whiteColor];
}

- (void)setModel:(id<IMessageModel>)model{
   _model = model;
    switch (model.bodyType) {
        case EMMessageBodyTypeText:
        {
           
            
            
            if ([model.message.ext[infotype]  isEqualToString:launch] ) {/**启动*/
                self.messageLable.text = model.text; self.messageLable.textColor = [SVGloble colorWithHexString:@"#FFB138"];
            }else if([model.message.ext[infotype]  isEqualToString:end]){/**结束*/
                 self.messageLable.text = model.text;self.messageLable.textColor = [SVGloble colorWithHexString:@"#FFB138"];
            }else if([model.message.ext[infotype]  isEqualToString:join_queue]){/**加入队列*/
               [self nameText];
            }else if([model.message.ext[infotype]  isEqualToString:leave_queue]){/**离开队列*/
               [self nameText];
            }else if([model.message.ext[infotype]  isEqualToString:kick_queue]){/**踢出队列*/
              [self nameText];
            }else if([model.message.ext[infotype]  isEqualToString:kick_room]){/**踢出房间*/
                [self nameText];
            }else if([model.message.ext[infotype]  isEqualToString:open_queue]){/**打开位置*/
              
            }else if([model.message.ext[infotype]  isEqualToString:close_queue]){/**关闭位置*/
               
            }else if([model.message.ext[infotype]  isEqualToString:startgame]){/**的环信消息，是启动链接*/
               
            }else{
                  [self nameText];
            }
            
            
            
            
            
           
            
        }
            
            break;
        default:
            break;
    }
}

-(void)nameText{
    // 初始化属性字符串
    NSString * attrstr = [NSString stringWithFormat:@"%@：%@",_model.nickname ,_model.text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:attrstr];
    NSRange rag = [attrstr rangeOfString:_model.text];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[SVGloble colorWithHexString:@"#FFB138"] range:rag];
    self.messageLable.attributedText = attrStr;
}
+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    YWRoomChatTableViewCell *cell = [self appearance];
    CGFloat bubbleMaxWidth = LFscreenW-72;
    CGFloat height = 0;
 
    switch (model.bodyType) {
        case EMMessageBodyTypeText:
        {
              NSString * attrstr = nil;
            
            if ([model.message.ext[infotype]  isEqualToString:launch] ) {/**启动*/
                attrstr =  model.text;
            }else if([model.message.ext[infotype]  isEqualToString:end]){/**结束*/
                 attrstr =  model.text;
            }else if([model.message.ext[infotype]  isEqualToString:join_queue]){/**加入队列*/
                attrstr = [NSString stringWithFormat:@"%@：%@",model.nickname ,model.text];
            }else if([model.message.ext[infotype]  isEqualToString:leave_queue]){/**离开队列*/
                attrstr = [NSString stringWithFormat:@"%@：%@",model.nickname ,model.text];
            }else if([model.message.ext[infotype]  isEqualToString:kick_queue]){/**踢出队列*/
               attrstr = [NSString stringWithFormat:@"%@：%@",model.nickname ,model.text];
            }else if([model.message.ext[infotype]  isEqualToString:kick_room]){/**踢出房间*/
                attrstr = [NSString stringWithFormat:@"%@：%@",model.nickname ,model.text];
            }else if([model.message.ext[infotype]  isEqualToString:open_queue]){/**打开位置*/
                
            }else if([model.message.ext[infotype]  isEqualToString:close_queue]){/**关闭位置*/
                
            }else if([model.message.ext[infotype]  isEqualToString:startgame]){/**的环信消息，是启动链接*/
                
            }else{
                attrstr = [NSString stringWithFormat:@"%@：%@",model.nickname ,model.text];
            }
            NSAttributedString *text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:model.text textFont:[UIFont systemFontOfSize:12]];
            CGRect rect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            height = rect.size.height+10 ;
            
           
        }
            break;
        default:
            break;
            
    }
      model.cellHeight = height;
       return height;
}
@end
