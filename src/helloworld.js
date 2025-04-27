import{ S3Client, ListBucketsCommand } from "@aws-sdk/client-s3";

export const handler = async (event) => {
  const client = new S3Client({ region: "us-east-1" });

  try {
    const data = await client.send(new ListBucketsCommand({}));
    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Hello, World!",
        buckets: data.Buckets,
      }),
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: "An error occurred",
        error: error.message,
      }),
    };
  }
};