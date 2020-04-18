//
//  FormTextView.m
//  FormSubmitList
//
//  Created by 郑桂华 on 2019/12/20.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FormTextView.h"

@interface FormTextView ()

@property(nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation FormTextView

@synthesize placeholder = _placeholder;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize placeholderTextColor = _placeholderTextColor;

-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
}

-(void)dealloc
{
    [_placeholderLabel removeFromSuperview];
    _placeholderLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

-(void)refreshPlaceholder
{
    if([[self text] length] || [[self attributedText] length])
    {
        [_placeholderLabel setAlpha:0];
    }
    else
    {
        [_placeholderLabel setAlpha:1];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self refreshPlaceholder];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    self.placeholderLabel.textAlignment = textAlignment;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.frame = [self placeholderExpectedFrame];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    [self refreshPlaceholder];
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    
    self.placeholderLabel.attributedText = attributedPlaceholder;
    [self refreshPlaceholder];
}

-(void)setPlaceholderTextColor:(UIColor*)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    self.placeholderLabel.textColor = placeholderTextColor;
}

-(UIEdgeInsets)placeholderInsets
{
    return UIEdgeInsetsMake(self.textContainerInset.top, self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.bottom, self.textContainerInset.right + self.textContainer.lineFragmentPadding);
}

-(CGRect)placeholderExpectedFrame
{
    UIEdgeInsets placeholderInsets = [self placeholderInsets];
    CGFloat maxWidth = CGRectGetWidth(self.frame)-placeholderInsets.left-placeholderInsets.right;
    
    CGSize expectedSize = [self.placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGRectGetHeight(self.frame)-placeholderInsets.top-placeholderInsets.bottom)];
    
    return CGRectMake(placeholderInsets.left, placeholderInsets.top, maxWidth, expectedSize.height);
}

-(UILabel*)placeholderLabel
{
    if (_placeholderLabel == nil)
    {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = self.font;
        _placeholderLabel.textAlignment = self.textAlignment;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        _placeholderLabel.alpha = 0;
        [self addSubview:_placeholderLabel];
    }
    
    return _placeholderLabel;
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
-(id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholder];
    return [super delegate];
}

-(CGSize)intrinsicContentSize
{
    if (self.hasText) {
        return [super intrinsicContentSize];
    }
    
    UIEdgeInsets placeholderInsets = [self placeholderInsets];
    CGSize newSize = [super intrinsicContentSize];
    
    newSize.height = [self placeholderExpectedFrame].size.height + placeholderInsets.top + placeholderInsets.bottom;
    
    return newSize;
}
@end
