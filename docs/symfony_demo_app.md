# Symfony
#### Contents
* [1. Directories](#1-directories) 
* [2. Links](#2-links)
* [3. Files](#3-files)
* [4. Commands](#4-commands)
* [5. Database](#5-database)
* [6. Generate entities from existing DB](#6-generate-entities-from-existing-db)
* [7. Generate admin class from existing entity](#7-generate-admin-class-from-existing-entity)
* [8. Hide id field from forms](#8-hide-id-field-from-forms)
* [9. Sonata admin functions](#9-sonata-admin-functions)
* [10. Configure generated entities](#10-configure-generated-entities)
* [11. Styling forms](#11-styling-forms)
* [12. Foreign keys](#12-foreign-keys)
* [13. Translations](#13-translations)
* [14. Generate dynamic select boxes](#14-generate-dynamic-select-boxes)
* [15. Parent-Child Entity Form Handling](#15-parent-child-entity-form-handling)
* [20. Error handling](#20-error-handling)
* [21. Php.ini](#21-php.ini)

#### 1. Directories
```bash
/vendor  # libraries (composer downloads here outside libraries)
/app     # configuration
/bin     # holds executable files that composer added
/src     # bundles are here
/web     # document root (public documents i.e. css and js)
```

Symfony 3.1.4 was successfully installed. Now you can:

    * Configure your application in app/config/parameters.yml file.

    * Run your application:
        1. Execute the php bin/console server:run command.
        2. Browse to the http://localhost:8000 URL.

    * Read the documentation at http://symfony.com/doc
    
    
#### 2. Links
http://localhost:8000/config.php _Configurations Checker_  
http://localhost:8000/app_dev.php _Developement Enviroment_  
http://localhost:8000/app.php _Application_   
http://localhost:8000/admin/dashboard  _admin interface_


#### 3. Files
/private/etc/php.ini    _THE php.ini_  
/app/AppKernel.php      _register bundles_  
/app/config/config.yml  _configure bundles_
/app/config/routing.yml _urls of the app_
/app/config/services.yml _urls of the app_
/app/config/parameters.yml _database access_
#### 4. Commands
```bash
php bin/console cache:clear         # clear cache
php bin/console server:run          # start php server
php bin/symfony_requirements        # check requirements
php bin/console debug:router        # lists all routes
php bin/console                     # lists all available commands
composer update                     # updates and installes/unistalles according to composer.json | also generates the parameters.yml from parameters.yml.dist 
php bin/console assets:install      # make a hard copy of the assets in web/
php bin/console doctrine:schema:update --dump-sql       # view but NOT execute the sql command
php bin/console doctrine:schema:update --force          # executer the command above
php bin/console doctrine:generate:entities AppBundle    # generate setters and getters i.e. /src/AppBundle/Entity/Car.php
php app/console sonata:admin:generate AppBundle/Entity/Car # generated admin class from existing entity
php bin/console assets:install --symlink                # if possible, make absolute symlinks in web/ if not, make a hard copy
php bin/console doctrine:schema:validate                # validate schema

```

#### 5. Database
In order to connect to the database, a new user has to be added and granded all privilages. In Sequel Pro:
Database->User Accounts..->Select root->Add host->%(is like a wildcard)->check all privilages and add the user

#### 6. Generate entities from existing DB
1. Ask Doctrine to introspect the database and generate the corresponding metadata files  
`php bin/console doctrine:mapping:import --force AcmeBlogBundle xml`  
2. Ask Doctrine to build related entity classes by executing the following two commands. First command is not necessery if the class is already created  
`php bin/console doctrine:generate:entities AppBundle`    
`http://symfony.com/doc/current/doctrine/reverse_engineering.html`    

#### 7. Generate admin class from existing entity
1. Run the folloing command and use exactly the same name as the entity in the end  
`php bin/console sonata:admin:generate AppBundle/Entity/Car`    
2. Add entry at /app/config/services.yml  

```bash
services:   
    //here more services   
    admin.car:   
        class: AppBundle\Admin\CarAdmin  
        arguments: [~, AppBundle\Entity\Car, ~]  
        tags:  
            - { name: sonata.admin, manager_type: orm, label: Car }  
```

#### 8. Hide id field from forms
Id's with autoincrement should not be visible and configurable about the user. Delete the entries for id's in:    
`/src/AppBundle/Admin/SomethingAdmin.php`    
at:  
`protected function configureFormFields(FormMapper $formMapper)`    

#### 9. Sonata admin functions
```bash
configureDatagridFilters    #called when we use filters   
configureListFields         #called when listing items  
configureFormFields         #called when editing items
configureShowFields         #called when showing items
```

#### 10. Configure generated entities
Generated entities are automatically configured from AppBundle/Resources/config/doctrine directory. In order to configure them ourselves, we need to delete this directory and then add the following in EVERY entity:  
 ```php
 // at the top of the file
 use Doctrine\ORM\Mapping as ORM;
 
 // on top of every entity class
 /**
 * Image
 * @ORM\Table(name="image")
 * @ORM\Entity
 */
 
 // on top of every varialbe declared
 /**
 * @var string
 *
 * @ORM\Column(name="trans_path", type="string", length=64, nullable=true)
 *
 */
 ```

#### 11. Styling forms

###### a. Creating tabs
To separate form fields in different tabs, just configure `function configureFormFields` in the admin class.   
For example, the following will create 2 tabs (General / Video Copies):   
 ```php
 $formMapper
            ->tab("General")
                ->add('optionId')
            ->end()
            ->end()
                ->tab("Video Copies")
                ->add('videoCopies', 'sonata_type_collection', array(
                    'by_reference' => false
                    ), array(
                        'edit' => 'inline',
                        'inline' => 'table'
                    )
                )
            ->end()
        ;
 ```
 
#### 12. Foreign keys
 In order to implement the sql foreign keys functionality, these steps are needed in the Entities. For example Alpha.id has OneToMany with Beta.alhpa_ID.   
 In Alpha.php:
 
 ```php
  /**
  * @ORM\OneToMany(targetEntity="Beta", mappedBy="alhpa_ID", cascade={"persist"}, orphanRemoval=true)
  *
  */
 private $betas;
 ```       
  In Alpha.php
 ```php
public function __construct() {
    $this->betas = new \Doctrine\Common\Collections\ArrayCollection();
}
 ```    
 In Alpha.php  //where lightOptions = betas (too long to change)
 ```php
   public function setLightOptions($lightOptions)
    {
        if (count($lightOptions) > 0) {
            foreach ($lightOptions as $i) {
                $this->addLightOption($i);
            }
        }

        return $this;
    }

    public function addLightOption(LightOption $lightOption)
    {
        $lightOption->setCarId($this);

        $this->lightOptions->add($lightOption);
    }

    public function removeLightOption(LightOption $lightOption)
    {
        $this->lightOptions->removeElement($lightOption);
    }

    public function getLightOptions()
    {
        return $this->lightOptions;
    }
 ```       
 In Beta.php  
 ```php
/**
* @var integer
*
* @ORM\ManyToOne(targetEntity="Alpha", inversedBy="betas", cascade={"detach"})
* @ORM\JoinColumn(name="beta_ID", referencedColumnName="id")
*/
private $beta_ID;
 ```
 
#### 13. Translations
Find out how to add the translations bundle. This manual expects that translation bundle is already installed.  
If you have labels in `config.yml` that are previewed in the Dashboard i.e :   
```yml
sonata_admin:
    dashboard:
        blocks:
            -
                position: left
                type: sonata.admin.block.admin_list
                settings:
                    groups: [demoapp.admin.group.car]
        groups:
            demoapp.admin.group.car:
                label: demoapp.admin.group.car
                icon:  '<i class="fa fa-car"></i>'
                items: [admin.car, admin.video,  admin.demooption, admin.feature, admin.image]
```
in order to translate these labels you need to configure first the `services.yml` like that:  
```yml
admin.car:
    class: AppBundle\Admin\CarAdmin
    arguments: [~, AppBundle\Entity\Car, ~]
    tags:
        - { name: sonata.admin, manager_type: orm, label: demoapp.admin.car }
# do the same for admin.video,  admin.demooption, admin.feature, admin.image   of course
```  
then add these 2 files for each language you want to support:  
`messages.de.yml`
```yml
demoapp.admin.car:
        Fahrzeuge
demoapp.admin.video:
        Videos
# etc etc--
```  
and
`SonataAdminBundle.de.yml`
```yml
demoapp.admin.group.car:
        Fahrzeuge
```  

#### 14. Generate dynamic select boxes
Let's take a live example from demo app. There are three tables like that: Cars (OneToMany) LightOptions (OneToMany) Features.  
When the user wants to add a new feature, it should be relative to a light option and a car. So, a acceptable configuration would be to have a select box for the Car
and then a dynamicly generated select box for ONLY the AVAILABLE LightOptions of that car! HTF are we gonna do it..?   

1. install FOSjRoutingBundle, register, enable etc etc..
2. copy this: vendor/sonata-project/admin-bundle/Resources/views/CRUD/base_edit.html.twig   to: src/AppBundle/Resources/views/Feature/base_edit.html.twig
3. add the following lines to the new above file 
```php
<script src="{{ asset('bundles/fosjsrouting/js/router.js') }}"></script>
```
4. configure services.yml for feature to:  
```yml

    admin.feature:
        class: AppBundle\Admin\FeatureAdmin
        arguments: [~, AppBundle\Entity\Feature, AppBundle:FeatureAdmin]
        tags:
            - { name: sonata.admin, manager_type: orm, label: lightapp.admin.feature }
```
5. add $cars to Feature.php (and setters getters..): 
```php
    /**
     * @var string
     *
     */
    private $cars;
```
6. in configureFormFields in FeatureAdmin.php change lightoptionId to :  
```php
->add('lightoptionId', EntityType::class, array(
    'class' => 'AppBundle:Lightoption',
    'query_builder' => function (EntityRepository $er) {
        return $er->createQueryBuilder('u')
            ->orderBy('u.optionId', 'ASC');
    },
    'choice_label' => 'optionId',
))
```
7. AND also add this function and this 2 lines on top:
```php
    use Symfony\Bridge\Doctrine\Form\Type\EntityType;
    use Doctrine\ORM\EntityRepository;
    // in your admin class
    public function getTemplate($name)
    {
        switch ($name) {
            case 'edit':
                return 'AppBundle:Feature:base_edit.html.twig';
                break;
            default:
                return parent::getTemplate($name);
                break;
        }
    }
```
8. create src/AppBundle/Controller/FeatureAdminController.php:
```php
namespace AppBundle\Controller;
use Sonata\AdminBundle\Controller\CRUDController as Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use GD\AdminBundle\Entity\Merchant;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
class FeatureAdminController extends Controller
{
    public function getLightOptionsFromCarAction($carId)
    {   
        $html = "";
        $option = $this->getDoctrine()
            ->getRepository('AppBundle:Lightoption')
            ->findByCarId($carId);
        foreach($option as $cat){
            $html .= '<option value="'.$cat->getId().'" >'.$cat->getOptionId().'</option>';
        }
        return new Response($html, 200);
    }
}
```

###### Links
http://symfony.com/doc/master/bundles/FOSJsRoutingBundle/index.html  
http://stackoverflow.com/questions/10118868/how-to-use-ajax-within-sonata-admin-forms  
http://symfony.com/doc/current/reference/forms/types/entity.html#query-builder  
http://stackoverflow.com/questions/9052916/how-to-use-select-box-related-on-another-select-box   

#### 15. Parent-Child Entity Form Handling
Given Translation Entity and Copy Entity (translation|"parent" , copy|"child") with OneToMany between them. We want to have on parent's create form a btn "add new" for the copies.
The subform should NOT contain the field `translation_ID`. It should be set automatically. One the other hand, when we add a new Copy, then there should be a select box with all the available translations and choose from them.   
Add/Conf in Translation.php:   
```php
/**
 * @ORM\OneToMany(targetEntity="Copy", mappedBy="translationId", cascade={"persist"}, orphanRemoval=true)
 *
 */
private $copies;
//add setters,getters and construct for $copies
public function __toString() {
    return (string) $this->getOptionId();
}
```  
Edit formMapper of CopyAdmin.php:   
```php
//more adds..
if ($this->getRequest()->get('code') !== 'admin.translation') {
     $em = $this->modelManager->getEntityManager('AppBundle\Entity\Translation');

    $query = $em->createQueryBuilder('c')
            ->select('c')
            ->from('AppBundle:Translation', 'c');
   $formMapper->add('translationId', 'sonata_type_model', array(
        'required' => true,
        'query' => $query,
        'btn_add' => false
    ));
}
$formMapper->end();
```
Edit formMapper of TranslationAdmin.php:
```php
->add('copies', 'sonata_type_collection', array(
        'by_reference' => false
            ), array(
                'edit' => 'inline',
                'inline' => 'table'
            )
    )
```


#### 20. Error handling
1. when running `php bin/console doctrine:schema:validate` and the error is `[Database] FAIL - The database schema is not in sync with the current mapping file.`.  We have to export the db, empty the tables, run `php bin/console doctrine:schema:update --dump-sql` and then `php bin/console doctrine:schema:update -f` and in the end import the previous dumped db.
2. Populate Database. When trunctate or instert is needed, the FK should be disabled in order for them to work. First run `SET FOREIGN_KEY_CHECKS = 0;` then do the changes and then run `SET FOREIGN_KEY_CHECKS = 0;`


#### 21. Php.ini
restart php server for changes to have effect!!!
