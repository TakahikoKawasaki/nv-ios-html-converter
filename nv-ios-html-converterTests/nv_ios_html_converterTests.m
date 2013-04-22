/*
 * Copyright (C) 2013 Neo Visionaries Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


//----------------------------------------------------------------------
// Headers
//----------------------------------------------------------------------
#import "nv_ios_html_converterTests.h"
#import "HTMLConverter.h"


//----------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------
@implementation nv_ios_html_converterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}


- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)doText:(HTMLConverter *)converter input:(NSString *)input expected:(NSString *)expected
{
    NSString *output = [converter toHTML:input];

    STAssertEqualObjects(output, expected, @"Input    = %@\nExpected = %@\nOutput   = %@", input, expected, output);
}


- (void)testEntityReferences
{
    NSString *input = @"&<>\"'    ";
    NSString *expected = @"&amp;&lt;&gt;&quot;&apos; &nbsp; &nbsp;";

    HTMLConverter *converter = [[HTMLConverter alloc] init];

    [self doText:converter input:input expected:expected];
}


- (void)testNewlines
{
    NSString *input = @"\nA\r\nB\rC";
    NSString *expected = @"<br/>A<br/>B<br/>C";

    HTMLConverter *converter = [[HTMLConverter alloc] init];
    
    [self doText:converter input:input expected:expected];
}


- (void)testTwitterHash1
{
    NSString *input = @"#hello";
    NSString *expected = @"<a href='https://twitter.com/search?q=%23hello'>#hello</a>";

    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.twitterFlag = YES;
    
    [self doText:converter input:input expected:expected];
}


- (void)testTwitterHash2
{
    NSString *input = @"#hello";
    NSString *expected = @"<a href='https://twitter.com/search?q=%23hello' data-link-type='twitter-hash'>#hello</a>";
    
    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.twitterFlag = YES;
    converter.customAttributeForTwitterLinkFlag = YES;

    [self doText:converter input:input expected:expected];
}


- (void)testTwitterMention1
{
    NSString *input = @"@hello";
    NSString *expected = @"<a href='https://twitter.com/hello'>@hello</a>";
    
    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.twitterFlag = YES;
    
    [self doText:converter input:input expected:expected];
}


- (void)testTwitterMention2
{
    NSString *input = @"@hello";
    NSString *expected = @"<a href='https://twitter.com/hello' data-link-type='twitter-mention'>@hello</a>";
    
    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.twitterFlag = YES;
    converter.customAttributeForTwitterLinkFlag = YES;
    
    [self doText:converter input:input expected:expected];
}


- (void)testUrl1
{
    NSString *input = @"http://example.com/";
    NSString *expected = @"<a href='http://example.com/'>http://example.com/</a>";
    
    HTMLConverter *converter = [[HTMLConverter alloc] init];
    
    [self doText:converter input:input expected:expected];
}


- (void)testUrl2
{
    NSString *input = @"http://example.com/";
    NSString *expected = @"<a href='http://example.com/'>example.com/</a>";
    
    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.cutSchemeFlag = YES;
    
    [self doText:converter input:input expected:expected];
}


- (void)test1
{
    NSString *input = @"Hello, I'm @abc and interested in #xyz.\nSee https://example.com/";
    NSString *expected = @"Hello, I&apos;m <a href='https://twitter.com/abc'>@abc</a> and interested in <a href='https://twitter.com/search?q=%23xyz'>#xyz</a>.<br/>See <a href='https://example.com/'>https://example.com/</a>";

    HTMLConverter *converter = [[HTMLConverter alloc] init];
    converter.twitterFlag = YES;
    
    [self doText:converter input:input expected:expected];
}


@end
