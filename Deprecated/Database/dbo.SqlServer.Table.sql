/****** Object:  Table [dbo].[SqlServer]    Script Date: 07/09/2008 12:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SqlServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SqlServer](
	[Server] [varchar](255) NOT NULL,
	[IsEnabled] [bit] NOT NULL CONSTRAINT [DF__SqlServer__IsEnabled]  DEFAULT ((1)),
 CONSTRAINT [PK_SqlServer] PRIMARY KEY CLUSTERED 
(
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
