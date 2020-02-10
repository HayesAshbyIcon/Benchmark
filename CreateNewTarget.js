var collectionName = "asdfasdf"

db.createCollection(collectionName, {
    validator: {
       $jsonSchema: {
          bsonType: "object",
          required: [ "Serial", "Model", "Build", "Android", "Chipset", "ChipsetHardware", "ChipsetRelease" ],
          properties: {
            Serial: {
                bsonType: "string",
                description: "Serial"
             },
             Model: {
                string: ["asdf"],
                description: "Device Model Mismatch"
             },
             Build: {
                string: ["asdf"],
                description: "Device Build Mismatch"
             },
             Android: {
                string: ["asdf"],
                description: "Device Build Mismatch"
             },
             Chipset: {
                string: [ "asdf" ],
                description: "Chipset Mismatch"
             },
             ChipsetHardware: {
                string: [ "asdf" ],
                description: "Chipset Hardware Version Mismatch"
             },
             ChipsetRelease: {
                string: [ "asdf" ],
                description: "Chipset Release Version Mismatch"
             },
            //  TestResults: {
            //     bsonType: "object",
            //     properties: {
            //         cputest: {
            //             bsonType
            //         }
            //     }
            //  }
          }
       }
    }
 })