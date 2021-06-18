export const getListingItems = () => {
  function main() {
    return new Promise(function (resolve, reject) {
      const Cloudant = require("@cloudant/cloudant");
      const cloudant = Cloudant({
        url: "https://7ae9ef74-43a4-45d4-a1a7-b22f2b9a429b-bluemix:6462636a5a6617432f81ac567e917a323e8b5ac2c25f2f0826b4683a3039827c@7ae9ef74-43a4-45d4-a1a7-b22f2b9a429b-bluemix.cloudantnosqldb.appdomain.cloud",
        plugins: {
          iamauth: { iamApiKey: "admin" },
        },
      });

      const envdb = cloudant.use("environment");
      envdb
        .find({ selector: {} })
        .then((result) => {
          if (result.docs[0]) {
            var newData = result.docs.map((p) => ({
              id: p.id,
              title: p.title,
              price: p.price,
              imageUrl: p.imageUrl,
              ecoRating: p.ecoRating,
              rating: p.rating,
              minQty: 40,
            }));
            return newData;
            // }
          } else {
            reject({
              headers: { "Content-Type": "application/json" },
              statusCode: 404,
              body: { error: "Not found." },
            });
          }
        })
        .then((result) => {
          resolve({
            body: result,
          });
        });
    });
  }
};
