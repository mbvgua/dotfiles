import asyncio


async def main():
    print("Hello...")
    await asyncio.sleep(1)
    print("....word")


asyncio.run(main())
